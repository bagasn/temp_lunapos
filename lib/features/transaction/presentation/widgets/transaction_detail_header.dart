import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';

class TransactionDetailHeader extends StatelessWidget {
  final TransactionUiModel? transaction;

  const TransactionDetailHeader({super.key, required this.transaction});

  static const Color _syncTealColor = Color(0xFF00C49A);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tx = transaction;

    final orderNumberText = tx != null ? '#${tx.orderNumber}' : '#-';
    final (statusLabel, statusColor) = switch (tx?.status) {
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
      null => ('-', AppColors.textDark),
    };

    final showSyncStatus =
        tx != null && tx.status != TransactionOrderStatus.active;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.charcoal200)),
      ),
      child: Row(
        children: [
          // Left: Order Number + Status & Sync Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  orderNumberText,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      statusLabel,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                    if (showSyncStatus) ...[
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.cloud_sync,
                        size: 20,
                        color: _syncTealColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        tx.isSynced ? l10n.txt_synced : l10n.txt_notSynced,
                        style: const TextStyle(
                          fontSize: 15,
                          color: _syncTealColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Right: Action Buttons
          if (tx != null) _buildActionButtons(context, l10n, tx, showSyncStatus),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    AppLocalizations l10n,
    TransactionUiModel tx,
    bool showSyncStatus,
  ) {
    if (tx.status == TransactionOrderStatus.active) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFD30404),
              side: const BorderSide(color: Color(0xFFD30404)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size(90, 42),
            ),
            child: Text(l10n.btn_voidOrder),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size(90, 42),
            ),
            child: Text(l10n.btn_continueOrder),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (tx.status == TransactionOrderStatus.completed) ...[
          // Share WhatsApp Button
          _HeaderIconButton(
            backgroundColor: const Color(0xFFF4F5F6),
            onTap: () {},
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_in_talk_rounded,
                size: 13,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 6),

          // Print Receipt Button
          _HeaderIconButton(
            backgroundColor: const Color(0xFFF4F5F6),
            onTap: () {},
            child: const Icon(
              Icons.print,
              size: 22,
              color: AppColors.charcoal950,
            ),
          ),
          const SizedBox(width: 6),
        ],

        // Sync Button
        if (showSyncStatus) ...[
          _HeaderIconButton(
            backgroundColor: _syncTealColor,
            onTap: () => context.read<TransactionBloc>().add(
              SyncTransactionEvent(transactionId: tx.id),
            ),
            child: const Icon(
              Icons.cloud_sync,
              size: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
        ],

        // More Options Dropdown
        if (tx.status == TransactionOrderStatus.completed)
          PopupMenuButton<String>(
            offset: const Offset(0, 44),
            color: Colors.white,
            onSelected: (_) {},
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'pdf',
                child: Text(l10n.btn_sendPdfReceipt),
              ),
              PopupMenuItem<String>(
                value: 'cancel',
                child: Text(l10n.btn_statusCancel),
              ),
            ],
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.charcoal200),
              ),
              child: const Icon(
                Icons.more_vert,
                size: 22,
                color: AppColors.primary,
              ),
            ),
          ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final VoidCallback onTap;

  const _HeaderIconButton({
    required this.backgroundColor,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: child,
      ),
    );
  }
}
