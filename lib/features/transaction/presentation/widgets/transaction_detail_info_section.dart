import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';

class TransactionDetailInfoSection extends StatelessWidget {
  final TransactionUiModel? transaction;

  const TransactionDetailInfoSection({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tx = transaction;
    final dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');

    final orderDateStr = tx != null
        ? dateTimeFormat.format(tx.orderDate)
        : '-';
    final closingDateStr = tx?.closingDate != null
        ? dateTimeFormat.format(tx!.closingDate!)
        : '-';

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            child: Column(
              children: [
                _InfoLabelValueRow(
                  label: l10n.lbl_orderDate,
                  value: orderDateStr,
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_closingDate,
                  value: closingDateStr,
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_queueNumber,
                  value: tx?.queueNumber ?? '-',
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_server,
                  value: tx?.serverName ?? '-',
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_cashier,
                  value: tx?.cashierName ?? '-',
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_table,
                  value: tx?.tableName ?? '-',
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_paxGuests,
                  value: tx?.paxCount != null ? '${tx!.paxCount}' : '-',
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          // Right Column
          Expanded(
            child: Column(
              children: [
                _InfoLabelValueRow(
                  label: l10n.lbl_customer,
                  value: tx?.customerName ?? '-',
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_email,
                  value: tx?.customerEmail ?? '-',
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_phoneNumber,
                  value: tx?.customerPhone ?? '-',
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_orderType,
                  value: tx?.orderType ?? '-',
                ),
                _InfoLabelValueRow(
                  label: l10n.lbl_salesType,
                  value: tx?.salesType ?? '-',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoLabelValueRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLabelValueRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textDark,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
