import 'package:flutter/material.dart';
import 'package:pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/shared/utilities/number_formatter.dart';

class TransactionDetailItemsSection extends StatelessWidget {
  final List<TransactionLineUiModel> lines;

  const TransactionDetailItemsSection({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.charcoal200)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: lines.isEmpty
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                '-',
                style: TextStyle(fontSize: 13, color: AppColors.textDark),
              ),
            )
          : Column(
              children: [
                for (int i = 0; i < lines.length; i++)
                  _OrderLineRow(
                    line: lines[i],
                    giftLabel: l10n.lbl_gift,
                  ),
              ],
            ),
    );
  }
}

class _OrderLineRow extends StatelessWidget {
  final TransactionLineUiModel line;
  final String giftLabel;

  const _OrderLineRow({required this.line, required this.giftLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.charcoal100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 56,
                child: Text(
                  'x${line.qty}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  line.name,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              if (line.isGift)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.card_giftcard,
                      size: 16,
                      color: Color(0xFF6CC04A),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      giftLabel,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00C49A),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'Rp ${NumberFormatter.decimal(line.totalPrice)}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textDark,
                  ),
                ),
            ],
          ),
          if (line.variantName != null && line.variantName!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 56, top: 4),
              child: Text(
                line.variantName!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMedium,
                ),
              ),
            ),
          if (line.notes != null && line.notes!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 56, top: 4),
              child: Text(
                line.notes!,
                style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: AppColors.textMedium,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
