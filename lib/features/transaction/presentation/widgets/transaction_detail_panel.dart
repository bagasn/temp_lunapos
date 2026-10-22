import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:pos/features/transaction/presentation/widgets/transaction_detail_footer_section.dart';
import 'package:pos/features/transaction/presentation/widgets/transaction_detail_header.dart';
import 'package:pos/features/transaction/presentation/widgets/transaction_detail_info_section.dart';
import 'package:pos/features/transaction/presentation/widgets/transaction_detail_items_section.dart';

class TransactionDetailPanel extends StatelessWidget {
  const TransactionDetailPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final selectedTx = state.selectedTransaction;

        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TransactionDetailHeader(transaction: selectedTx),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TransactionDetailInfoSection(transaction: selectedTx),
                      TransactionDetailItemsSection(
                        lines: selectedTx?.lines ?? const [],
                      ),
                      TransactionDetailFooterSection(
                        transaction: selectedTx,
                        isHistoryShown: state.isHistoryShown,
                      ),
                    ],
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
