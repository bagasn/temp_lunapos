import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';

class TransactionFilterSection extends StatelessWidget {
  const TransactionFilterSection({super.key});

  Future<void> _pickDate(
    BuildContext context, {
    required DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final now = DateTime(2026, 10, 22);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime(2030),
    );
    if (picked != null) {
      onPicked(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('yyyy-MM-dd');

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final bloc = context.read<TransactionBloc>();

        return Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Range Row
              Row(
                children: [
                  Expanded(
                    child: _DateInputBox(
                      dateText: state.startDate != null
                          ? dateFormat.format(state.startDate!)
                          : '-',
                      onTap: () => _pickDate(
                        context,
                        initialDate: state.startDate,
                        lastDate: state.endDate,
                        onPicked: (date) => bloc.add(
                          UpdateTransactionDateRange(startDate: date),
                        ),
                      ),
                      onClear: () => bloc.add(
                        const UpdateTransactionDateRange(clearStartDate: true),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      l10n.txt_to,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _DateInputBox(
                      dateText: state.endDate != null
                          ? dateFormat.format(state.endDate!)
                          : '-',
                      onTap: () => _pickDate(
                        context,
                        initialDate: state.endDate,
                        firstDate: state.startDate,
                        onPicked: (date) => bloc.add(
                          UpdateTransactionDateRange(endDate: date),
                        ),
                      ),
                      onClear: () => bloc.add(
                        const UpdateTransactionDateRange(clearEndDate: true),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Status Label
              Text(
                l10n.lbl_status,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 10),

              // Status Buttons Row
              Row(
                children: [
                  Expanded(
                    child: _StatusFilterButton(
                      label: l10n.btn_statusCompleted,
                      isSelected:
                          state.statusFilter ==
                          TransactionOrderStatus.completed,
                      onTap: () => bloc.add(
                        const ChangeTransactionStatusFilter(
                          TransactionOrderStatus.completed,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatusFilterButton(
                      label: l10n.btn_statusCancel,
                      isSelected:
                          state.statusFilter == TransactionOrderStatus.cancel,
                      onTap: () => bloc.add(
                        const ChangeTransactionStatusFilter(
                          TransactionOrderStatus.cancel,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatusFilterButton(
                      label: l10n.btn_statusActive,
                      isSelected:
                          state.statusFilter == TransactionOrderStatus.active,
                      onTap: () => bloc.add(
                        const ChangeTransactionStatusFilter(
                          TransactionOrderStatus.active,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Reset Filter Button
              SizedBox(
                height: 40,
                width: 145,
                child: ElevatedButton(
                  onPressed: () => bloc.add(const ResetTransactionFilters()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD30404),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    l10n.btn_resetFilter,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DateInputBox extends StatelessWidget {
  final String dateText;
  final VoidCallback onTap;
  final VoidCallback onClear;

  const _DateInputBox({
    required this.dateText,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.charcoal200),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: AppColors.textDark,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                dateText,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textDark,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: onClear,
              child: const Icon(
                Icons.cancel,
                size: 18,
                color: AppColors.charcoal400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusFilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusFilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.charcoal200,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
