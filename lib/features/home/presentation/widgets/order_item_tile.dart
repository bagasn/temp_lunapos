import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/home/data/models/order_model.dart';
import 'package:pos/shared/utilities/currency_formatter.dart';

class OrderItemTile extends StatelessWidget {
  final OrderLineModel orderLine;
  final void Function(int delta) onQuantityChange;
  final VoidCallback onRemove;

  const OrderItemTile({
    super.key,
    required this.orderLine,
    required this.onQuantityChange,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColorConstants.borderLight),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  orderLine.productName,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColorConstants.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: AppColorConstants.textLight,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // Quantity controls
              _QuantityControl(
                quantity: orderLine.quantity.toInt(),
                onDecrease: () => onQuantityChange(-1),
                onIncrease: () => onQuantityChange(1),
              ),
              const Spacer(),
              // Subtotal
              Text(
                CurrencyFormatter.format(orderLine.subTotal),
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColorConstants.primaryPurple,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const _QuantityControl({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColorConstants.borderLight),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(Icons.remove_rounded, onDecrease),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '$quantity',
              style: AppTextStyles.titleMedium,
            ),
          ),
          _buildButton(Icons.add_rounded, onIncrease),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 16, color: AppColorConstants.primaryPurple),
      ),
    );
  }
}
