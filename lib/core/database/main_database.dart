import 'package:drift/drift.dart';
import 'package:pos/core/database/connection/connection.dart';

import 'package:pos/core/database/tables/main/address.dart';
import 'package:pos/core/database/tables/main/area_user_relation.dart';
import 'package:pos/core/database/tables/main/area.dart';
import 'package:pos/core/database/tables/main/category.dart';
import 'package:pos/core/database/tables/main/comission_order_line_relation.ts.dart';
import 'package:pos/core/database/tables/main/coupon_order.dart';
import 'package:pos/core/database/tables/main/customer.dart';
import 'package:pos/core/database/tables/main/delivery_address.dart';
import 'package:pos/core/database/tables/main/delivery.dart';
import 'package:pos/core/database/tables/main/discount.dart';
import 'package:pos/core/database/tables/main/employee_product_commission_relation.dart';
import 'package:pos/core/database/tables/main/employee.dart';
import 'package:pos/core/database/tables/main/linked_order.dart';
import 'package:pos/core/database/tables/main/modifier_item.dart';
import 'package:pos/core/database/tables/main/modifier.dart';
import 'package:pos/core/database/tables/main/order_line_modifier.dart';
import 'package:pos/core/database/tables/main/order_line.dart';
import 'package:pos/core/database/tables/main/order_log.dart';
import 'package:pos/core/database/tables/main/order_merged.dart';
import 'package:pos/core/database/tables/main/order_payment.dart';
import 'package:pos/core/database/tables/main/order_tax.dart';
import 'package:pos/core/database/tables/main/order.dart';
import 'package:pos/core/database/tables/main/outlet_setting.dart';
import 'package:pos/core/database/tables/main/payment_method.dart';
import 'package:pos/core/database/tables/main/price_level_pricelist.dart';
import 'package:pos/core/database/tables/main/price_level.dart';
import 'package:pos/core/database/tables/main/price_tier_order.dart';
import 'package:pos/core/database/tables/main/price_tier.dart';
import 'package:pos/core/database/tables/main/printer_area_rel.dart';
import 'package:pos/core/database/tables/main/printer_area.dart';
import 'package:pos/core/database/tables/main/printer.dart';
import 'package:pos/core/database/tables/main/printout_template.dart';
import 'package:pos/core/database/tables/main/product_category_relation.dart';
import 'package:pos/core/database/tables/main/product_modifier_relation.dart';
import 'package:pos/core/database/tables/main/product_pricelist.dart';
import 'package:pos/core/database/tables/main/product_user_relation.dart';
import 'package:pos/core/database/tables/main/product_variant.dart';
import 'package:pos/core/database/tables/main/product.dart';
import 'package:pos/core/database/tables/main/promo_extension.dart';
import 'package:pos/core/database/tables/main/promo_order.dart';
import 'package:pos/core/database/tables/main/promo_product_reward.dart';
import 'package:pos/core/database/tables/main/promo_product_term.dart';
import 'package:pos/core/database/tables/main/promo_product_variant_reward.dart';
import 'package:pos/core/database/tables/main/promo_product_variant_term.dart';
import 'package:pos/core/database/tables/main/promo_to_payment_method_rel.dart';
import 'package:pos/core/database/tables/main/promo_to_sales_type_rel.dart';
import 'package:pos/core/database/tables/main/promo.dart';
import 'package:pos/core/database/tables/main/qpon_order.dart';
import 'package:pos/core/database/tables/main/qris_bank_acquirer.dart';
import 'package:pos/core/database/tables/main/qris_history.dart';
import 'package:pos/core/database/tables/main/qris_payment_method.dart';
import 'package:pos/core/database/tables/main/sales_type.dart';
import 'package:pos/core/database/tables/main/scanner.dart';
import 'package:pos/core/database/tables/main/shift_session.dart';
import 'package:pos/core/database/tables/main/table_management.dart';
import 'package:pos/core/database/tables/main/table.dart';
import 'package:pos/core/database/tables/main/tax.dart';
import 'package:pos/core/database/tables/main/transaction_log.dart';
import 'package:pos/core/database/tables/main/user.dart';

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
    TablePaymentMethod,
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
