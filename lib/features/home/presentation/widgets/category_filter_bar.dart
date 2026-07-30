import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/home/domain/entities/product_entity.dart';

class CategoryFilterBar extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String? selectedCategoryId;
  final void Function(String? categoryId) onCategorySelected;

  const CategoryFilterBar({
    super.key,
    required this.categories,
    this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterChip(
            label: 'Semua',
            isSelected: selectedCategoryId == null,
            onTap: () => onCategorySelected(null),
          ),
          _FilterChip(
            label: 'Favorit',
            isSelected: selectedCategoryId == 'favorites',
            onTap: () => onCategorySelected('favorites'),
          ),
          ...categories.map(
            (cat) => _FilterChip(
              label: cat.name,
              isSelected: selectedCategoryId == cat.id,
              onTap: () => onCategorySelected(cat.id),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColorConstants.primaryPurple
                : AppColorConstants.backgroundLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? AppColorConstants.primaryPurple
                  : AppColorConstants.borderLight,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.labelLarge.copyWith(
              color: isSelected
                  ? AppColorConstants.textWhite
                  : AppColorConstants.textMedium,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
