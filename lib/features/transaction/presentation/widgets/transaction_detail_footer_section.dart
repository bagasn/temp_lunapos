import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/shared/utilities/number_formatter.dart';

class TransactionDetailFooterSection extends StatelessWidget {
  final TransactionUiModel? transaction;
  final bool isHistoryShown;

  const TransactionDetailFooterSection({
    super.key,
    required this.transaction,
    required this.isHistoryShown,
  });

  String _formatAccountingRp(double value) {
    final hasDecimals = (value - value.truncateToDouble()).abs() > 0.001;
    final formatted = NumberFormatter.decimal(
      value,
      decimalDigits: hasDecimals ? 2 : 0,
    );
    return 'Rp$formatted';
  }

  String _formatPaymentRp(double value) {
    final hasDecimals = (value - value.truncateToDouble()).abs() > 0.001;
    final formatted = NumberFormatter.decimal(
      value,
      decimalDigits: hasDecimals ? 2 : 0,
    );
    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tx = transaction;

    final serviceChargeLabel =
        tx?.serviceChargeRate != null && tx!.serviceChargeRate! > 0
        ? '${l10n.lbl_serviceCharge} (${NumberFormatter.decimal(tx.serviceChargeRate!)}%)'
        : l10n.lbl_serviceCharge;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.charcoal200)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Payment Breakdown
              Expanded(child: _buildPaymentColumn(l10n, tx)),

              const SizedBox(width: 28),

              // Right Column: Accounting Summary
              Expanded(
                child: Column(
                  children: [
                    _SummaryRow(
                      label: l10n.lbl_subtotal,
                      value: _formatAccountingRp(tx?.subTotal ?? 0),
                    ),
                    const SizedBox(height: 12),
                    _SummaryRow(
                      label: l10n.lbl_discount,
                      value: _formatAccountingRp(tx?.discountAmount ?? 0),
                    ),
                    const SizedBox(height: 12),
                    _SummaryRow(
                      label: serviceChargeLabel,
                      value: _formatAccountingRp(tx?.serviceChargeAmount ?? 0),
                    ),
                    const SizedBox(height: 12),
                    _SummaryRow(
                      label: l10n.lbl_tax,
                      value: _formatAccountingRp(tx?.taxAmount ?? 0),
                    ),
                    const SizedBox(height: 12),
                    _SummaryRow(
                      label: l10n.lbl_adjustment,
                      value: _formatAccountingRp(tx?.adjustmentAmount ?? 0),
                    ),
                    const SizedBox(height: 14),
                    _SummaryRow(
                      label: l10n.lbl_totalItems(tx?.totalItemsCount ?? 0),
                      value: _formatAccountingRp(tx?.totalAmount ?? 0),
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 1, color: AppColors.charcoal100),

          if (tx != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Center(
                child: GestureDetector(
                  onTap: () => context.read<TransactionBloc>().add(
                    const ToggleTransactionHistory(),
                  ),
                  child: Text(
                    isHistoryShown
                        ? l10n.btn_hideHistory
                        : l10n.btn_showHistory,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textDark,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            if (isHistoryShown) _buildHistoryTable(l10n, tx.logs),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentColumn(AppLocalizations l10n, TransactionUiModel? tx) {
    final payments = tx?.payments ?? const [];

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Text(
            l10n.title_payment,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 20),
          if (payments.isEmpty)
            Text(
              l10n.txt_noPayment,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textMedium,
              ),
            )
          else ...[
            for (final payment in payments)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      payment.methodName,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      _formatPaymentRp(payment.amount),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.charcoal200,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.lbl_totalPayment,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  _formatPaymentRp(tx?.tenderAmount ?? 0),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.lbl_change,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  _formatPaymentRp(tx?.changeAmount ?? 0),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryTable(
    AppLocalizations l10n,
    List<TransactionLogUiModel> logs,
  ) {
    final logDateFormat = DateFormat('dd-MM-yyyy HH:mm');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.charcoal100,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.lbl_logUserName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  l10n.lbl_logDate,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  l10n.lbl_logDescription,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (final log in logs)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.charcoal100)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    log.userName,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    logDateFormat.format(log.dateTime),
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    log.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = isTotal ? 16.0 : 13.0;
    final labelWeight = isTotal ? FontWeight.w700 : FontWeight.w400;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: labelWeight,
              color: AppColors.textDark,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 4,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
