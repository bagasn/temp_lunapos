import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:pos/features/transaction/presentation/widgets/transaction_filter_section.dart';
import 'package:pos/features/transaction/presentation/widgets/transaction_item_card.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';

class TransactionListPanel extends StatefulWidget {
  const TransactionListPanel({super.key});

  @override
  State<TransactionListPanel> createState() => _TransactionListPanelState();
}

class _TransactionListPanelState extends State<TransactionListPanel> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<TransactionBloc, TransactionState>(
      listenWhen: (prev, curr) => prev.searchQuery != curr.searchQuery,
      listener: (context, state) {
        if (_searchController.text != state.searchQuery) {
          _searchController.text = state.searchQuery;
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, l10n),
            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.charcoal200,
            ),
            Expanded(child: _buildTransactionList(context, l10n)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final bloc = context.read<TransactionBloc>();

        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row 1: POS / Online Order Switcher + Sync Button
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.charcoal100,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _SourceSwitchTab(
                              label: l10n.lbl_pos,
                              badgeCount: state.posOrderCount,
                              isSelected:
                                  state.activeSource ==
                                  TransactionOrderSource.pos,
                              onTap: () => bloc.add(
                                const SwitchTransactionSource(
                                  TransactionOrderSource.pos,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: _SourceSwitchTab(
                              label: l10n.lbl_onlineOrder,
                              badgeCount: state.onlineOrderCount,
                              isSelected:
                                  state.activeSource ==
                                  TransactionOrderSource.onlineOrder,
                              onTap: () => bloc.add(
                                const SwitchTransactionSource(
                                  TransactionOrderSource.onlineOrder,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () => bloc.add(const SyncTransactionEvent()),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.sync,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Row 2: Search Order Input + Filter Toggle Button
              Row(
                children: [
                  Expanded(
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
                            Icons.search,
                            size: 22,
                            color: AppColors.charcoal700,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) =>
                                  bloc.add(SearchTransactionChanged(value)),
                              decoration: InputDecoration(
                                hintText: l10n.hint_searchOrder,
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.charcoal400,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              bloc.add(const SearchTransactionChanged(''));
                            },
                            child: const Icon(
                              Icons.cancel,
                              size: 20,
                              color: AppColors.charcoal400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () => bloc.add(const ToggleTransactionFilterPanel()),
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      width: 46,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.charcoal200),
                      ),
                      child: Icon(
                        state.isFilterExpanded
                            ? Icons.close
                            : Icons.filter_alt,
                        size: 22,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),

              // Collapsible Filter Section
              if (state.isFilterExpanded) const TransactionFilterSection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransactionList(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state.status == TransactionLoadStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final transactions = state.filteredTransactions;
        if (transactions.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                l10n.txt_orderNotFound,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textMedium,
                ),
              ),
            ),
          );
        }

        final dateHeaderFormat = DateFormat('EEEE, dd/MM/yyyy');

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tx = transactions[index];
            final currentDayStr = dateHeaderFormat.format(tx.displayDate);
            final prevDayStr = index > 0
                ? dateHeaderFormat.format(transactions[index - 1].displayDate)
                : null;
            final showDateHeader = index == 0 || currentDayStr != prevDayStr;
            final isSelected = state.selectedTransaction?.id == tx.id;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showDateHeader)
                  Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? 0 : 8,
                      bottom: 12,
                    ),
                    child: Row(
                      children: [
                        Text(
                          currentDayStr,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Divider(
                            color: AppColors.charcoal200,
                            thickness: 1.5,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                TransactionItemCard(
                  transaction: tx,
                  isSelected: isSelected,
                  onTap: () => context.read<TransactionBloc>().add(
                    SelectTransaction(tx.id),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _SourceSwitchTab extends StatelessWidget {
  final String label;
  final int badgeCount;
  final bool isSelected;
  final VoidCallback onTap;

  const _SourceSwitchTab({
    required this.label,
    required this.badgeCount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(48),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textDark,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFF0000),
                shape: BoxShape.circle,
              ),
              child: Text(
                '$badgeCount',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
