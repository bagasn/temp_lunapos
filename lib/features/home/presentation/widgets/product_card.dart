import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/home/domain/entities/product_entity.dart';
import 'package:pos/shared/utilities/currency_formatter.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = product.isOutOfStock;
    return Material(
      color: AppColorConstants.surfaceCard,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: isOutOfStock ? null : onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColorConstants.borderLight,
            ),
          ),
          child: Opacity(
            opacity: isOutOfStock ? 0.5 : 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Product image
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      _buildImage(),
                      if (isOutOfStock) _buildOutOfStockBadge(),
                      if (product.isFavorite) _buildFavoriteBadge(),
                    ],
                  ),
                ),
                // Product info
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.name,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColorConstants.textDark,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          CurrencyFormatter.format(product.price),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColorConstants.primaryPurple,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (product.stock != null && !isOutOfStock)
                          Text(
                            'Sisa ${product.stock!.toInt()} pcs',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColorConstants.textLight,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    final url = product.pictureUrl;
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (ctx, url) => Container(
          color: AppColorConstants.backgroundLight,
          child: const Icon(
            Icons.fastfood_outlined,
            color: AppColorConstants.textLight,
          ),
        ),
        errorWidget: (ctx, url, err) => _defaultImage(),
      );
    }
    return _defaultImage();
  }

  Widget _defaultImage() {
    return Container(
      color: AppColorConstants.backgroundLight,
      child: const Center(
        child: Icon(
          Icons.fastfood_outlined,
          color: AppColorConstants.textLight,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildOutOfStockBadge() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        color: Colors.black54,
        child: const Text(
          'STOK HABIS',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteBadge() {
    return Positioned(
      top: 6,
      right: 6,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: AppColorConstants.badgeFavorite,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.favorite_rounded,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }
}
