import 'package:drift/drift.dart';
import 'package:pos/core/database/connection/connection.dart';

import 'package:pos/core/database/tables/pos/address.dart';
import 'package:pos/core/database/tables/pos/area_user_relation.dart';
import 'package:pos/core/database/tables/pos/area.dart';
import 'package:pos/core/database/tables/pos/category.dart';
import 'package:pos/core/database/tables/pos/comission_order_line_relation.ts.dart';
import 'package:pos/core/database/tables/pos/coupon_order.dart';
import 'package:pos/core/database/tables/pos/customer.dart';
import 'package:pos/core/database/tables/pos/delivery_address.dart';
import 'package:pos/core/database/tables/pos/delivery.dart';
import 'package:pos/core/database/tables/pos/discount.dart';
import 'package:pos/core/database/tables/pos/employee_product_commission_relation.dart';
import 'package:pos/core/database/tables/pos/employee.dart';
import 'package:pos/core/database/tables/pos/linked_order.dart';
import 'package:pos/core/database/tables/pos/modifier_item.dart';
import 'package:pos/core/database/tables/pos/modifier.dart';
import 'package:pos/core/database/tables/pos/order_line_modifier.dart';
import 'package:pos/core/database/tables/pos/order_line.dart';
import 'package:pos/core/database/tables/pos/order_log.dart';
import 'package:pos/core/database/tables/pos/order_merged.dart';
import 'package:pos/core/database/tables/pos/order_payment.dart';
import 'package:pos/core/database/tables/pos/order_tax.dart';
import 'package:pos/core/database/tables/pos/order.dart';
import 'package:pos/core/database/tables/pos/outlet_setting.dart';
import 'package:pos/core/database/tables/pos/price_level_pricelist.dart';
import 'package:pos/core/database/tables/pos/price_level.dart';
import 'package:pos/core/database/tables/pos/price_tier_order.dart';
import 'package:pos/core/database/tables/pos/price_tier.dart';
import 'package:pos/core/database/tables/pos/printer_area_rel.dart';
import 'package:pos/core/database/tables/pos/printer_area.dart';
import 'package:pos/core/database/tables/pos/printer.dart';
import 'package:pos/core/database/tables/pos/printout_template.dart';
import 'package:pos/core/database/tables/pos/product_category_relation.dart';
import 'package:pos/core/database/tables/pos/product_modifier_relation.dart';
import 'package:pos/core/database/tables/pos/product_pricelist.dart';
import 'package:pos/core/database/tables/pos/product_user_relation.dart';
import 'package:pos/core/database/tables/pos/product_variant.dart';
import 'package:pos/core/database/tables/pos/product.dart';
import 'package:pos/core/database/tables/pos/promo_extension.dart';
import 'package:pos/core/database/tables/pos/promo_order.dart';
import 'package:pos/core/database/tables/pos/promo_product_reward.dart';
import 'package:pos/core/database/tables/pos/promo_product_term.dart';
import 'package:pos/core/database/tables/pos/promo_product_variant_reward.dart';
import 'package:pos/core/database/tables/pos/promo_product_variant_term.dart';
import 'package:pos/core/database/tables/pos/promo_to_payment_method_rel.dart';
import 'package:pos/core/database/tables/pos/promo_to_sales_type_rel.dart';
import 'package:pos/core/database/tables/pos/promo.dart';
import 'package:pos/core/database/tables/pos/qpon_order.dart';
import 'package:pos/core/database/tables/pos/qris_bank_acquirer.dart';
import 'package:pos/core/database/tables/pos/qris_history.dart';
import 'package:pos/core/database/tables/pos/qris_payment_method.dart';
import 'package:pos/core/database/tables/pos/sales_type.dart';
import 'package:pos/core/database/tables/pos/scanner.dart';
import 'package:pos/core/database/tables/pos/shift_session.dart';
import 'package:pos/core/database/tables/pos/table_management.dart';
import 'package:pos/core/database/tables/pos/table.dart';
import 'package:pos/core/database/tables/pos/tax.dart';
import 'package:pos/core/database/tables/pos/transaction_log.dart';
import 'package:pos/core/database/tables/pos/user.dart';

part 'main_database.g.dart';

@DriftDatabase(
  tables: [
    TableAddress,
    TableAreaToUserRel,
    TableArea,
    TableCategory,
    TableCommissionToOrderLine,
    TableCouponOrder,
    TableCustomer,
    TableDeliveryAddress,
    TableDelivery,
    TableDiscount,
    TableEmployeeToProductCommissionRelation,
    TableEmployee,
    TableLinkedOrder,
    TableModifierItem,
    TableModifier,
    TableOrderLineModifier,
    TableOrderLine,
    TableOrderLog,
    TableOrderMerged,
    TableOrderPayment,
    TableOrderTax,
    TableOrder,
    TableOutletSetting,
    TablePriceLevelPriceList,
    TablePriceLevel,
    TablePriceTierOrderLine,
    TablePriceTier,
    TablePrinterAreaRel,
    TablePrinterArea,
    TablePrinter,
    TablePrintoutTemplate,
    TableProductCategoryRelation,
    TableProductModifierRelation,
    TableProductPricelist,
    TableproductToUserRel,
    TableProductVariant,
    TableProduct,
    TablePromoExtension,
    TablePromoOrder,
    TablePromoProductReward,
    TablePromoProductTerm,
    TablePromoProductVariantReward,
    TablePromoProductVariantTerm,
    TablePromoToPaymentMethodRel,
    TablePromoToSalesTypeRel,
    TablePromo,
    TableQponOrder,
    TableQrisBankAcquirer,
    TableQrisHistory,
    TableQrisPaymentMethod,
    TableSalesType,
    TableScanner,
    TableShiftSession,
    TableTableManagement,
    TableTable,
    TableTax,
    TableTransactionLog,
    TableUser,
  ],
)
class MainDatabase extends _$MainDatabase {
  MainDatabase(String dbName) : super(connectDatabase(dbName));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // if (from < 1) {
      //   await m.createAll();
      // }
    },
  );
}
