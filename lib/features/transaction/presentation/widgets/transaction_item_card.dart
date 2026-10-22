import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/shared/utilities/number_formatter.dart';

class TransactionItemCard extends StatelessWidget {
  final TransactionUiModel transaction;
  final bool isSelected;
  final VoidCallback onTap;

  const TransactionItemCard({
    super.key,
    required this.transaction,
    required this.isSelected,
    required this.onTap,
  });

  static const Color _syncTealColor = Color(0xFF00C49A);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr = transaction.status == TransactionOrderStatus.active
        ? '-'
        : DateFormat('dd/MM/yyyy').format(transaction.displayDate);
    final timeStr = transaction.status == TransactionOrderStatus.active
        ? '-'
        : DateFormat('HH:mm').format(transaction.displayDate);

    final (statusLabel, statusColor) = switch (transaction.status) {
      TransactionOrderStatus.completed => (
        l10n.btn_statusCompleted,
        AppColors.textDark,
      ),
      TransactionOrderStatus.cancel => (
        l10n.btn_statusCancel,
        AppColors.statusError,
      ),
      TransactionOrderStatus.active => (
        l10n.btn_statusActive,
        _syncTealColor,
      ),
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.charcoal200,
            width: isSelected ? 1.2 : 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NO. ORDER: POS-221026-2
                  Row(
                    children: [
                      Text(
                        l10n.lbl_orderNoPrefix,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          transaction.orderNumber,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Customer Row
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 16,
                        color: AppColors.textDark,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          transaction.customerName ?? '-',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Table Row
                  Row(
                    children: [
                      const Icon(
                        Icons.table_restaurant_outlined,
                        size: 16,
                        color: AppColors.textDark,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          transaction.tableName ?? '-',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Status Row
                  Row(
                    children: [
                      const Icon(
                        Icons.assignment_outlined,
                        size: 16,
                        color: AppColors.textDark,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        statusLabel,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Right Column
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Date
                  Text(
                    dateStr,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Time
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time_filled,
                        size: 15,
                        color: AppColors.textDark,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        timeStr,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Total Amount
                  Text(
                    NumberFormatter.currency(transaction.totalAmount),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Sync Status
                  if (transaction.status != TransactionOrderStatus.active)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.cloud_sync,
                          size: 18,
                          color: _syncTealColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          transaction.isSynced
                              ? l10n.txt_synced
                              : l10n.txt_notSynced,
                          style: const TextStyle(
                            fontSize: 12,
                            color: _syncTealColor,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
