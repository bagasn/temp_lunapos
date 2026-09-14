import 'package:flutter/material.dart';
import 'package:pos/features/pos/presentation/widgets/product_item.dart';
import 'package:pos/generated/colors.gen.dart';

// --- Mock Data Models (UI only) ---
class _MockProduct {
  final String name;
  final String price;
  final String? stockLabel;
  final bool isOutOfStock;
  final bool hasVariant;

  const _MockProduct({
    required this.name,
    required this.price,
    this.stockLabel,
    this.isOutOfStock = false,
    this.hasVariant = false,
  });
}

class _MockCategory {
  final String label;
  final int count;
  final IconData? icon;
  final Color? iconColor;

  const _MockCategory({
    required this.label,
    required this.count,
    this.icon,
    this.iconColor,
  });
}

// --- Mock Data ---
const _categories = [
  _MockCategory(label: 'Semua', count: 40),
  _MockCategory(
    label: 'Favorit',
    count: 6,
    icon: Icons.favorite,
    iconColor: Color(0xFFE91E63),
  ),
  _MockCategory(
    label: 'Promo & Diskon',
    count: 10,
    icon: Icons.local_offer_outlined,
    iconColor: Color(0xFF27AE60),
  ),
  _MockCategory(label: 'Ayam', count: 10),
  _MockCategory(label: 'Daging', count: 10),
  _MockCategory(label: 'Minuman', count: 8),
];

const _products = [
  _MockProduct(
    name: 'Ayam Penyet + Nasi',
    price: 'Rp32.000',
    stockLabel: '10 Pcs',
    hasVariant: true,
  ),
  _MockProduct(name: 'Como Kitchen', price: 'Rp36.000'),
  _MockProduct(name: 'Parking pizza', price: 'Rp20.000'),
  _MockProduct(name: 'GreenVita', price: 'Rp18.000'),
  _MockProduct(name: 'Chickpeas', price: 'Rp36.000', isOutOfStock: true),
  _MockProduct(name: 'Gelatin', price: 'Rp25.000'),
  _MockProduct(
    name: 'Bean sprouts',
    price: 'Rp47.000',
    isOutOfStock: true,
    hasVariant: true,
  ),
  _MockProduct(name: 'Minuman 1', price: 'Rp20.000'),
  _MockProduct(name: 'Pecans', price: 'Rp36.000'),
  _MockProduct(name: 'Scallops', price: 'Rp40.000', hasVariant: true),
  _MockProduct(name: 'Cantaloupes', price: 'Rp32.000', hasVariant: true),
  _MockProduct(name: 'Ginger ale', price: 'Rp36.000'),
];

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTopBar(),
        _buildCategoryRow(),
        const Divider(height: 1, thickness: 1, color: AppColors.borderLight),
        Expanded(child: _buildProductGrid()),
      ],
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderLight)),
      ),
      child: Row(
        children: [
          // Title with count
          Row(
            children: [
              const Icon(
                Icons.apps_rounded,
                size: 20,
                color: AppColors.textDark,
              ),
              const SizedBox(width: 8),
              Text(
                'Semua (${_products.length})',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Search Field
          Expanded(
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.surfaceInput,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.search,
                    size: 18,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Nama/SKU Produk',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: AppColors.textLight,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.qr_code_scanner,
                    size: 18,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Action Buttons
          _buildActionIconButton(Icons.receipt_long_outlined),
          const SizedBox(width: 8),
          _buildActionIconButton(Icons.discount_outlined, filled: true),
        ],
      ),
    );
  }

  Widget _buildActionIconButton(IconData icon, {bool filled = false}) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: filled ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: filled ? AppColors.primary : AppColors.borderLight,
        ),
      ),
      child: Icon(
        icon,
        size: 18,
        color: filled ? Colors.white : AppColors.textMedium,
      ),
    );
  }

  Widget _buildCategoryRow() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategoryIndex == index;
          return _buildCategoryChip(category, isSelected, index);
        },
      ),
    );
  }

  Widget _buildCategoryChip(
    _MockCategory category,
    bool isSelected,
    int index,
  ) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategoryIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category.icon != null) ...[
              Icon(
                category.icon!,
                size: 13,
                color: isSelected ? Colors.white : category.iconColor,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              '${category.label} (${category.count})',
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : AppColors.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 240,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return ProductItem(
          name: product.name,
          price: product.price,
          stockLabel: product.stockLabel,
          isOutOfStock: product.isOutOfStock,
          hasVariant: product.hasVariant,
        );
      },
    );
  }
}
