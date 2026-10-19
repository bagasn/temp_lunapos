import 'package:equatable/equatable.dart';

/// Entity representing a single template setting item (e.g. Bill or Receipt).
class PrintoutTemplateItem extends Equatable {
  final String id;
  final String name;
  final bool showLogo;
  final bool showOrderNumber;
  final bool showDate;
  final bool showAddress;
  final bool showCashierAndUser;
  final bool showAdjustment;
  final bool showTax;
  final bool showServiceCharge;
  final bool showUnitPriceProduct;
  final bool showUnitPriceModifier;

  const PrintoutTemplateItem({
    required this.id,
    required this.name,
    required this.showLogo,
    required this.showOrderNumber,
    required this.showDate,
    required this.showAddress,
    required this.showCashierAndUser,
    required this.showAdjustment,
    required this.showTax,
    required this.showServiceCharge,
    required this.showUnitPriceProduct,
    required this.showUnitPriceModifier,
  });

  const PrintoutTemplateItem.defaults({
    required this.id,
    required this.name,
  })  : showLogo = true,
        showOrderNumber = true,
        showDate = true,
        showAddress = true,
        showCashierAndUser = true,
        showAdjustment = true,
        showTax = true,
        showServiceCharge = true,
        showUnitPriceProduct = true,
        showUnitPriceModifier = true;

  PrintoutTemplateItem copyWith({
    String? id,
    String? name,
    bool? showLogo,
    bool? showOrderNumber,
    bool? showDate,
    bool? showAddress,
    bool? showCashierAndUser,
    bool? showAdjustment,
    bool? showTax,
    bool? showServiceCharge,
    bool? showUnitPriceProduct,
    bool? showUnitPriceModifier,
  }) {
    return PrintoutTemplateItem(
      id: id ?? this.id,
      name: name ?? this.name,
      showLogo: showLogo ?? this.showLogo,
      showOrderNumber: showOrderNumber ?? this.showOrderNumber,
      showDate: showDate ?? this.showDate,
      showAddress: showAddress ?? this.showAddress,
      showCashierAndUser: showCashierAndUser ?? this.showCashierAndUser,
      showAdjustment: showAdjustment ?? this.showAdjustment,
      showTax: showTax ?? this.showTax,
      showServiceCharge: showServiceCharge ?? this.showServiceCharge,
      showUnitPriceProduct: showUnitPriceProduct ?? this.showUnitPriceProduct,
      showUnitPriceModifier:
          showUnitPriceModifier ?? this.showUnitPriceModifier,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        showLogo,
        showOrderNumber,
        showDate,
        showAddress,
        showCashierAndUser,
        showAdjustment,
        showTax,
        showServiceCharge,
        showUnitPriceProduct,
        showUnitPriceModifier,
      ];
}

/// Entity representing the overall Template Settings.
class SettingTemplateEntity extends Equatable {
  final PrintoutTemplateItem bill;
  final PrintoutTemplateItem receipt;

  const SettingTemplateEntity({
    required this.bill,
    required this.receipt,
  });

  const SettingTemplateEntity.defaults()
      : bill = const PrintoutTemplateItem.defaults(id: 'bill', name: 'Bill'),
        receipt =
            const PrintoutTemplateItem.defaults(id: 'receipt', name: 'Receipt');

  SettingTemplateEntity copyWith({
    PrintoutTemplateItem? bill,
    PrintoutTemplateItem? receipt,
  }) {
    return SettingTemplateEntity(
      bill: bill ?? this.bill,
      receipt: receipt ?? this.receipt,
    );
  }

  @override
  List<Object?> get props => [bill, receipt];
}
