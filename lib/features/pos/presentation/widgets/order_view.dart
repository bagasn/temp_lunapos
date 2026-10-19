import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/features/pos/domain/entities/pos_order_line_entity.dart';
import 'package:pos/features/pos/presentation/bloc/order/pos_order_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/utilities/number_formatter.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PosOrderBloc, PosOrderState>(
      listenWhen: (prev, curr) => prev.saveStatus != curr.saveStatus,
      listener: (context, state) {
        if (state.saveStatus == PosOrderSaveStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Order berhasil disimpan!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.saveStatus == PosOrderSaveStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Gagal menyimpan order.'),
              backgroundColor: AppColors.statusError,
            ),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(color: AppColors.borderLight, width: 1.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            _buildMetaInfo(),
            const Divider(height: 1, thickness: 1, color: AppColors.borderLight),
            Expanded(child: _buildOrderList()),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Daftar Order',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
          _buildCircleIconButton(
            icon: Icons.more_horiz_rounded,
            backgroundColor: AppColors.primary,
            iconColor: Colors.white,
          ),
          const SizedBox(width: 8),
          _buildCircleIconButton(
            icon: Icons.delete_outline_rounded,
            backgroundColor: AppColors.statusError,
            iconColor: Colors.white,
            onTap: () =>
                context.read<PosOrderBloc>().add(const ClearOrder()),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIconButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
    );
  }

  Widget _buildMetaInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          _buildMetaRow(
            icon: Icons.storefront_outlined,
            label: 'Tipe Penjualan',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildMetaRow(
                  icon: Icons.person_outline_rounded,
                  label: 'Pelanggan',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetaRow(
                  icon: Icons.groups_outlined,
                  label: '- Pax',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildMetaRow(
            icon: Icons.chair_outlined,
            label: 'Pilih Meja',
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildMetaRow({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderPurple),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textPurple),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPurple,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return BlocBuilder<PosOrderBloc, PosOrderState>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Belum ada item.\nTap produk untuk menambahkan ke order.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textLight,
                ),
              ),
            ),
          );
        }

        final lines = state.order!.lines;
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemCount: lines.length,
          separatorBuilder: (_, _) =>
              const Divider(height: 1, thickness: 1, color: AppColors.borderLight),
          itemBuilder: (context, index) =>
              _buildOrderItem(context, lines[index]),
        );
      },
    );
  }

  Widget _buildOrderItem(BuildContext context, PosOrderLineEntity line) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item name and total price
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  line.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Text(
                NumberFormatter.currency(line.lineTotal),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          // Unit price
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              '@${NumberFormatter.currency(line.unitPrice)}',
              style: const TextStyle(fontSize: 11, color: AppColors.textLight),
            ),
          ),

          const SizedBox(height: 8),

          // Actions row: Catatan | Hapus — Quantity controls
          Row(
            children: [
              _buildTextActionButton(
                icon: Icons.receipt_outlined,
                label: 'Catatan',
                color: AppColors.textMedium,
                onTap: () {},
              ),
              _buildDividerSeparator(),
              _buildTextActionButton(
                icon: Icons.local_offer_outlined,
                label: 'Diskon',
                color: AppColors.textMedium,
                onTap: () {},
              ),
              _buildDividerSeparator(),
              _buildTextActionButton(
                icon: Icons.delete_outline,
                label: 'Hapus',
                color: AppColors.statusError,
                onTap: () => context
                    .read<PosOrderBloc>()
                    .add(RemoveOrderLine(line.id)),
              ),
              const Spacer(),
              _buildQuantityControl(context, line),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextActionButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style:
                TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildDividerSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(width: 1, height: 12, color: AppColors.borderLight),
    );
  }

  Widget _buildQuantityControl(
    BuildContext context,
    PosOrderLineEntity line,
  ) {
    return Row(
      children: [
        _buildQuantityButton(
          Icons.remove,
          onTap: () => context.read<PosOrderBloc>().add(
                UpdateOrderLineQty(
                  lineId: line.id,
                  newQty: line.qty - 1,
                ),
              ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '${line.qty}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ),
        _buildQuantityButton(
          Icons.add,
          onTap: () => context.read<PosOrderBloc>().add(
                UpdateOrderLineQty(
                  lineId: line.id,
                  newQty: line.qty + 1,
                ),
              ),
        ),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, size: 14, color: Colors.white),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return BlocBuilder<PosOrderBloc, PosOrderState>(
      builder: (context, state) {
        final isSaving = state.saveStatus == PosOrderSaveStatus.saving;
        final totalLabel =
            'Total (${state.totalQty} item${state.totalQty != 1 ? 's' : ''})';

        return Container(
          decoration: const BoxDecoration(
            color: AppColors.orderTotalBackground,
            border: Border(top: BorderSide(color: AppColors.borderLight)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Total row
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 20,
                      color: AppColors.textDark,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      totalLabel,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      NumberFormatter.currency(state.subTotal),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // Print & Save buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildFooterButton(
                        label: 'Print Tagihan',
                        backgroundColor: Colors.white,
                        textColor: AppColors.textDark,
                        borderColor: AppColors.borderLight,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildFooterButton(
                        label: isSaving ? 'Menyimpan...' : 'Simpan',
                        backgroundColor: AppColors.buttonSave,
                        textColor: Colors.white,
                        onTap: isSaving || state.isEmpty
                            ? null
                            : () => context
                                .read<PosOrderBloc>()
                                .add(const SaveOrderEvent()),
                      ),
                    ),
                  ],
                ),
              ),

              // Pay button
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: _buildFooterButton(
                  label: 'Bayar',
                  backgroundColor: AppColors.buttonPay,
                  textColor: Colors.white,
                  height: 46,
                  onTap: state.isEmpty ? null : () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooterButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
    double height = 38,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: onTap == null
              ? backgroundColor.withAlpha(140)
              : backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: borderColor != null ? Border.all(color: borderColor) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
