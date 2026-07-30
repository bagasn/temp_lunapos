import 'package:flutter/material.dart';
import 'package:pos/features/home/domain/entities/product_entity.dart';
import 'package:pos/features/home/presentation/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final void Function(ProductEntity product) onProductTap;

  const ProductGrid({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductCard(
        product: products[i],
        onTap: () => onProductTap(products[i]),
      ),
    );
  }
}
