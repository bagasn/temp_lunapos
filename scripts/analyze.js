const fs = require("fs");
const schema = require("./sequelize_schema.json");

const pluralToSingular = {
  addresses: "address",
  areaToUserRels: "areaToUserRel",
  areas: "area",
  categories: "category",
  commissionToOrderLineRels: "commissionToOrderLineRel",
  couponOrders: "couponOrder",
  customers: "customer",
  deliveries: "delivery",
  deliveryAddresses: "deliveryAddress",
  discounts: "discount",
  employeeToProductCommissionRels: "employeeToProductCommissionRel",
  employees: "employee",
  linkedOrders: "linkedOrder",
  modifierItems: "modifierItem",
  modifiers: "modifier",
  orderLineModifiers: "orderLineModifier",
  orderLines: "orderLine",
  orderLogs: "orderLog",
  orderMergeds: "orderMerged",
  orderPayments: "orderPayment",
  orderTaxes: "orderTax",
  orders: "order",
  outletSettings: "outletSetting",
  paymentMethods: "paymentMethod",
  priceLevelPricelists: "priceLevelPricelist",
  priceLevels: "priceLevel",
  priceTierOrderLines: "priceTierOrderLine",
  priceTiers: "priceTier",
  pricelists: "pricelist",
  printerAreaRels: "printerAreaRel",
  printerAreas: "printerArea",
  printers: "printer",
  printoutTemplates: "printoutTemplate",
  productCategoryRelations: "productCategoryRelation",
  productModifierRelations: "productModifierRelation",
  productToUserRels: "productToUserRel",
  productVariants: "productVariant",
  products: "product",
  promoExtensions: "promoExtension",
  promoOrders: "promoOrder",
  promoProductRewards: "promoProductReward",
  promoProductTerms: "promoProductTerm",
  promoProductVariantRewards: "promoProductVariantReward",
  promoProductVariantTerms: "promoProductVariantTerm",
  promoToPaymentMethodRels: "promoToPaymentMethodRel",
  promoToSalesTypeRels: "promoToSalesTypeRel",
  promos: "promo",
  qponOrders: "qponOrder",
  qrisBankAcquirers: "qrisBankAcquirer",
  qrisHistories: "qrisHistory",
  qrisPaymentMethods: "qrisPaymentMethod",
  salesTypes: "salesType",
  scanners: "scanner",
  shiftSessions: "shiftSession",
  tables: "table",
  TableManagement: "tableManagement",
  taxes: "tax",
  transactionLogs: "transactionLog",
  users: "user",
};

const driftDir = "lib/core/database/tables/main";
const driftFiles = fs.readdirSync(driftDir).filter((f) => f.endsWith(".dart"));

let planOutput = "";

driftFiles.forEach((file) => {
  const dartContent = fs.readFileSync(`${driftDir}/${file}`, "utf8");
  const dataClassNameMatch = dartContent.match(/@DataClassName\('([^']+)'\)/);
  if (!dataClassNameMatch) return;
  const dataClassName = dataClassNameMatch[1];
  const seqKey = pluralToSingular[dataClassName];
  if (!seqKey || !schema[seqKey]) {
    console.log("No schema found for " + dataClassName);
    return;
  }

  const seqModel = schema[seqKey];

  // Parse dart file lines
  const lines = dartContent.split("\n");
  let modifications = [];

  lines.forEach((line, index) => {
    const colMatch = line.match(
      /^\s*(TextColumn|IntColumn|RealColumn|BoolColumn|DateTimeColumn)\s+get\s+([a-zA-Z0-9_]+)\s*=>/,
    );
    if (colMatch) {
      const dartType = colMatch[1];
      const colName = colMatch[2];

      // base fields are handled by sequelize paranoid/timestamps automatically, not always explicitly in schema
      if (["createdAt", "updatedAt", "deletedAt"].includes(colName)) return;

      const seqField = seqModel[colName];
      if (!seqField) {
        // modifications.push(`- Column ${colName} not found in Sequelize schema.`);
        return;
      }

      let isNullable = true;
      let expectedType = "text";
      let defaultValue = null;

      if (typeof seqField === "string") {
        const s = seqField.toUpperCase();
        if (s.includes("UUID") || s.includes("STRING") || s.includes("TEXT"))
          expectedType = "text";
        if (s.includes("INTEGER") || s.includes("BIGINT"))
          expectedType = "integer";
        if (
          s.includes("FLOAT") ||
          s.includes("DOUBLE") ||
          s.includes("DECIMAL")
        )
          expectedType = "real";
        if (s.includes("BOOLEAN")) expectedType = "boolean";
        if (s.includes("DATE")) expectedType = "dateTime";
      } else {
        if (seqField.allowNull === false || seqField.primaryKey === true) {
          isNullable = false;
        }
        const s = String(seqField.type).toUpperCase();
        if (s.includes("UUID") || s.includes("STRING") || s.includes("TEXT"))
          expectedType = "text";
        if (s.includes("INTEGER") || s.includes("BIGINT"))
          expectedType = "integer";
        if (
          s.includes("FLOAT") ||
          s.includes("DOUBLE") ||
          s.includes("DECIMAL")
        )
          expectedType = "real";
        if (s.includes("BOOLEAN")) expectedType = "boolean";
        if (s.includes("DATE")) expectedType = "dateTime";

        if (seqField.defaultValue !== undefined) {
          defaultValue = seqField.defaultValue;
        }
      }

      // Current dart parsing
      let currentIsNullable = line.includes(".nullable()");
      let currentHasDefault = line.includes(".withDefault(");
      let currentExpectedTypeMatch = line.match(/=>\s*([a-zA-Z]+)\(\)/);
      let currentBaseType = currentExpectedTypeMatch
        ? currentExpectedTypeMatch[1]
        : "unknown";

      let needsChange = false;
      let newDef = `${expectedType.charAt(0).toUpperCase() + expectedType.slice(1)}Column get ${colName} => ${expectedType}()`;

      if (
        defaultValue !== null &&
        typeof defaultValue !== "function" &&
        typeof defaultValue !== "object" &&
        defaultValue !== "UUIDV4"
      ) {
        if (typeof defaultValue === "string") {
          newDef += `.withDefault(const Constant('${defaultValue}'))`;
        } else {
          newDef += `.withDefault(const Constant(${defaultValue}))`;
        }
      } else if (defaultValue === "UUIDV4") {
        newDef += `.clientDefault(() => const Uuid().v4())`;
        // or we can ignore default for UUIDV4 since Drift handles it separately if it's not set
      }

      if (isNullable) {
        newDef += `.nullable()`;
      }
      newDef += `();`;

      const currentLineTrimmed = line.trim();
      // Just basic normalization for comparison
      const currentNorm = currentLineTrimmed.replace(/\s+/g, "");
      const newNorm = newDef.replace(/\s+/g, "");

      if (currentNorm !== newNorm) {
        // Check if the only difference is clientDefault which we might want to ignore if it wasn't there
        if (
          !currentNorm.includes("clientDefault") &&
          newNorm.includes("clientDefault")
        ) {
          newDef = newDef.replace(/\.clientDefault\([^)]+\)/, "");
          const newNorm2 = newDef.replace(/\s+/g, "");
          if (currentNorm === newNorm2) return;
        }

        modifications.push(
          `  - \`${colName}\`: \n    - Current: \`${currentLineTrimmed}\`\n    - Target:  \`${newDef}\``,
        );
      }
    }
  });

  if (modifications.length > 0) {
    planOutput += `### [MODIFY] ${file}\n`;
    planOutput += modifications.join("\n") + "\n\n";
  }
});

fs.writeFileSync("scripts/plan_diff.txt", planOutput);
