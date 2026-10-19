import 'package:flutter/material.dart';
import 'package:pos/generated/assets.gen.dart';
import 'package:pos/generated/colors.gen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    this.stockLabel,
    this.isOutOfStock = false,
    this.hasVariant = false,
    this.onTap,
  });

  final String name;
  final String price;
  final String? imageUrl;
  final String? stockLabel;
  final bool isOutOfStock;
  final bool hasVariant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isOutOfStock ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderLight),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildImage()),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress?.cumulativeBytesLoaded ==
                      loadingProgress?.expectedTotalBytes) {
                    return child;
                  }
                  return _buildPlaceholderImage();
                },
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderImage();
                },
              )
            : _buildPlaceholderImage(),

        // Out of stock overlay
        if (isOutOfStock)
          Container(
            color: Colors.black.withValues(alpha: 0.6),
            child: const Center(
              child: Text(
                'STOK\nHABIS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
          ),

        // Stock label badge (top-left)
        if (stockLabel != null && !isOutOfStock)
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(topRight: Radius.circular(6)),
              ),
              child: Text(
                'Sisa Stok: $stockLabel',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

        // Variant icon (top-right)
        if (hasVariant && !isOutOfStock)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.apps_rounded,
                size: 14,
                color: AppColors.primary,
              ),
            ),
          ),

        // Variant icon on out-of-stock item (top-right)
        if (hasVariant && isOutOfStock)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.apps_rounded,
                size: 14,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholderImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Assets.images.imgDoodleBgProduct.image(
          fit: BoxFit.cover,
          color: Colors.grey.shade400,
          colorBlendMode: BlendMode.dstATop,
        ),
        Center(
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppColors.textDark),
          ),
          const SizedBox(height: 2),
          Text(
            price,
            style: const TextStyle(
              color: AppColors.priceColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
