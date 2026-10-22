import 'package:flutter/material.dart';
import 'package:pos/features/transaction/presentation/widgets/transaction_detail_panel.dart';
import 'package:pos/features/transaction/presentation/widgets/transaction_list_panel.dart';
import 'package:pos/generated/colors.gen.dart';

class TransactionNavView extends StatefulWidget {
  const TransactionNavView({super.key});

  @override
  State<TransactionNavView> createState() => _TransactionNavViewState();
}

class _TransactionNavViewState extends State<TransactionNavView> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 4, child: TransactionListPanel()),
        VerticalDivider(
          width: 1,
          thickness: 1,
          color: AppColors.charcoal200,
        ),
        Expanded(flex: 5, child: TransactionDetailPanel()),
      ],
    );
  }
}
