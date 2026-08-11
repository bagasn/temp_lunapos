import 'package:drift/drift.dart';
import 'connection/connection.dart';

import 'tables/account.dart';
import 'tables/address.dart';
import 'tables/area_user_relation.dart';
import 'tables/area.dart';
import 'tables/category.dart';
import 'tables/comission_order_line_relation.ts.dart';
import 'tables/coupon_order.dart';
import 'tables/customer.dart';
import 'tables/delivery_address.dart';
import 'tables/delivery.dart';
import 'tables/discount.dart';
import 'tables/display.dart';
import 'tables/employee_product_commission_relation.dart';
import 'tables/employee.dart';
import 'tables/linked_order.dart';
import 'tables/master_bank.dart';
import 'tables/master_city.dart';
import 'tables/master_district.dart';
import 'tables/master_province.dart';
import 'tables/master_village.dart';
import 'tables/modifier_item.dart';
import 'tables/modifier.dart';
import 'tables/order_line_modifier.dart';
import 'tables/order_line.dart';
import 'tables/order_log.dart';
import 'tables/order_merged.dart';
import 'tables/order_payment.dart';
import 'tables/order_tax.dart';
import 'tables/order.dart';
import 'tables/outlet_setting.dart';
import 'tables/outlet.dart';
import 'tables/price_level_pricelist.dart';
import 'tables/price_level.dart';
import 'tables/price_tier_order.dart';
import 'tables/price_tier.dart';
import 'tables/printer_area_rel.dart';
import 'tables/printer_area.dart';
import 'tables/printer.dart';
import 'tables/printout_template.dart';
import 'tables/product_category_relation.dart';
import 'tables/product_modifier_relation.dart';
import 'tables/product_pricelist.dart';
import 'tables/product_user_relation.dart';
import 'tables/product_variant.dart';
import 'tables/product.dart';
import 'tables/promo_extension.dart';
import 'tables/promo_order.dart';
import 'tables/promo_product_reward.dart';
import 'tables/promo_product_term.dart';
import 'tables/promo_product_variant_reward.dart';
import 'tables/promo_product_variant_term.dart';
import 'tables/promo_to_payment_method_rel.dart';
import 'tables/promo_to_sales_type_rel.dart';
import 'tables/promo.dart';
import 'tables/qpon_order.dart';
import 'tables/qris_bank_acquirer.dart';
import 'tables/qris_history.dart';
import 'tables/qris_payment_method.dart';
import 'tables/sales_type.dart';
import 'tables/scanner.dart';
import 'tables/shift_session.dart';
import 'tables/system_setting.dart';
import 'tables/table_management.dart';
import 'tables/table.dart';
import 'tables/tax.dart';
import 'tables/transaction_log.dart';
import 'tables/user.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    TableAccount,
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
    TableDisplay,
    TableEmployeeToProductCommissionRelation,
    TableEmployee,
    TableLinkedOrder,
    TableBank,
    TableCity,
    TableDistrict,
    TableProvince,
    TableVillage,
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
    TableOutlet,
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
    TableSystemSetting,
    TableTableManagement,
    TableTable,
    TableTax,
    TableTransactionLog,
    TableUser,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(String dbName) : super(connectDatabase(dbName));

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
