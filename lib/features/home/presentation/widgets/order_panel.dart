import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/home/data/models/order_model.dart';
import 'package:pos/features/home/presentation/bloc/pos/pos_bloc.dart';
import 'package:pos/features/home/presentation/bloc/pos/pos_event.dart';
import 'package:pos/features/home/presentation/bloc/pos/pos_state.dart';
import 'package:pos/features/home/presentation/widgets/order_item_tile.dart';
import 'package:pos/shared/utilities/number_formatter.dart';

class OrderPanel extends StatelessWidget {
  const OrderPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: AppColorConstants.surfaceOrderPanel,
        border: Border(left: BorderSide(color: AppColorConstants.borderLight)),
      ),
      child: BlocBuilder<PosBloc, PosState>(
        builder: (context, state) {
          if (state is PosOrderActive || state is PosSaving) {
            final order = state is PosOrderActive
                ? state.order
                : (state as PosSaving).order;
            return _buildOrderContent(context, order);
          }
          return _buildEmptyOrder(context);
        },
      ),
    );
  }

  Widget _buildOrderContent(BuildContext context, OrderModel order) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          decoration: const BoxDecoration(
            color: AppColorConstants.backgroundWhite,
            border: Border(
              bottom: BorderSide(color: AppColorConstants.borderLight),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.receipt_outlined,
                color: AppColorConstants.primaryPurple,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Daftar Order',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColorConstants.textDark,
                ),
              ),
              const Spacer(),
              if (order.orderLines.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColorConstants.primaryPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${order.orderLines.length}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Order lines
        Expanded(
          child: order.orderLines.isEmpty
              ? _buildEmptyLines()
              : ListView.builder(
                  itemCount: order.orderLines.length,
                  itemBuilder: (ctx, i) {
                    final line = order.orderLines[i];
                    return OrderItemTile(
                      orderLine: line,
                      onQuantityChange: (delta) {
                        final newQty = line.quantity + delta;
                        if (newQty <= 0) {
                          context.read<PosBloc>().add(
                            PosOrderLineRemoved(line.id),
                          );
                        } else {
                          context.read<PosBloc>().add(
                            PosOrderLineQuantityChanged(line.id, newQty),
                          );
                        }
                      },
                      onRemove: () => context.read<PosBloc>().add(
                        PosOrderLineRemoved(line.id),
                      ),
                    );
                  },
                ),
        ),

        // Total & Action buttons
        if (order.orderLines.isNotEmpty) _buildBottomSection(context, order),
      ],
    );
  }

  Widget _buildEmptyLines() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 56,
            color: AppColorConstants.textLight.withAlpha(128),
          ),
          const SizedBox(height: 12),
          Text(
            'Belum ada item',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColorConstants.textLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap produk untuk menambahkan',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColorConstants.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, OrderModel order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorConstants.backgroundWhite,
        border: const Border(
          top: BorderSide(color: AppColorConstants.borderLight),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Grand Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColorConstants.textDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                NumberFormatter.format(order.grandTotal),
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColorConstants.primaryPurple,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Print button
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.print_outlined, size: 18),
            label: const Text('Print Tagihan'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              foregroundColor: AppColorConstants.textMedium,
              side: const BorderSide(color: AppColorConstants.borderLight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Save and Pay row
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      context.read<PosBloc>().add(const PosSaveRequested()),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 48),
                    foregroundColor: AppColorConstants.primaryPurple,
                    side: const BorderSide(
                      color: AppColorConstants.primaryPurple,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Simpan'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () =>
                      context.read<PosBloc>().add(const PosPayRequested()),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 48),
                    backgroundColor: AppColorConstants.primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Bayar',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyOrder(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Text('Daftar Order', style: AppTextStyles.titleLarge),
        ),
        const Expanded(
          child: Center(
            child: CircularProgressIndicator(
              color: AppColorConstants.primaryPurple,
            ),
          ),
        ),
      ],
    );
  }
}
