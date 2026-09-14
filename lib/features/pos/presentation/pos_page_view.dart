import 'package:flutter/material.dart';
import 'package:pos/features/pos/presentation/widgets/order_view.dart';
import 'package:pos/features/pos/presentation/widgets/product_view.dart';

class PosPageView extends StatefulWidget {
  const PosPageView({super.key});

  @override
  State<PosPageView> createState() => _PosPageViewState();
}

class _PosPageViewState extends State<PosPageView> {
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
