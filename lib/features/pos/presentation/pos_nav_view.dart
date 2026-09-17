import 'package:flutter/material.dart';
import 'package:pos/features/pos/presentation/widgets/order_view.dart';
import 'package:pos/features/pos/presentation/widgets/product_view.dart';

class PosNavView extends StatefulWidget {
  const PosNavView({super.key});

  @override
  State<PosNavView> createState() => _PosNavViewState();
}

class _PosNavViewState extends State<PosNavView> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: ProductView()),
        SizedBox(width: 400, child: OrderView()),
      ],
    );
  }
}
