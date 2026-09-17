import 'package:flutter/material.dart';

class TransactionNavView extends StatefulWidget {
  const TransactionNavView({super.key});

  @override
  State<TransactionNavView> createState() => _TransactionNavViewState();
}

class _TransactionNavViewState extends State<TransactionNavView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Container(color: Colors.blue)),
        Expanded(child: Container(color: Colors.green)),
      ],
    );
  }
}
