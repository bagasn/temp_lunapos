import 'package:flutter/material.dart';
import 'package:pos/generated/colors.gen.dart';

// --- Mock Data Models (UI only) ---
class _MockOrderModifier {
  final String name;
  final String price;

  const _MockOrderModifier({required this.name, required this.price});
}

class _MockOrderItem {
  final String name;
  final String basePrice;
  final String totalPrice;
  final List<_MockOrderModifier> modifiers;
  final String? discount;
  final int quantity;
  final bool isFree;

  const _MockOrderItem({
    required this.name,
    required this.basePrice,
    required this.totalPrice,
    required this.modifiers,
    this.discount,
    required this.quantity,
    this.isFree = false,
  });
}

// --- Mock Data ---
const _mockOrderItems = [
  _MockOrderItem(
    name: 'Ayam Penyet + Nasi',
    basePrice: '@Rp10.000',
    totalPrice: 'Rp 20.000',
    modifiers: [
      _MockOrderModifier(name: 'Dada', price: '+ Rp 3.000'),
      _MockOrderModifier(name: 'Extra Sambal', price: '+ Rp 3.000'),
    ],
    discount: 'Diskon - Promo Malam Minggu (Rp)',
    quantity: 2,
  ),
  _MockOrderItem(
    name: 'Es Kopyor',
    basePrice: '',
    totalPrice: 'Gratis',
    modifiers: [
      _MockOrderModifier(name: 'Extra Ice', price: '+ Rp 0'),
    ],
    quantity: 2,
    isFree: true,
  ),
];

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: AppColors.borderLight, width: 1.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          _buildMetaInfo(),
          const Divider(height: 1, thickness: 1, color: AppColors.borderLight),
          Expanded(child: _buildOrderList()),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
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
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIconButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(icon, color: iconColor, size: 18),
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
                  label: 'Steven',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetaRow(
                  icon: Icons.groups_outlined,
                  label: '5 Pax',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildMetaRow(
            icon: Icons.chair_outlined,
            label: 'Smoking Area - Meja 20',
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
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: _mockOrderItems.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, thickness: 1, color: AppColors.borderLight),
      itemBuilder: (context, index) {
        return _buildOrderItem(_mockOrderItems[index]);
      },
    );
  }

  Widget _buildOrderItem(_MockOrderItem item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item name and price
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Text(
                item.totalPrice,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: item.isFree ? AppColors.textLight : AppColors.textDark,
                ),
              ),
            ],
          ),
          if (item.basePrice.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                item.basePrice,
                style: const TextStyle(fontSize: 11, color: AppColors.textLight),
              ),
            ),

          // Modifiers
          for (final mod in item.modifiers)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  const Icon(Icons.people_outline, size: 13, color: AppColors.textLight),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      mod.name,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMedium),
                    ),
                  ),
                  Text(
                    mod.price,
                    style: const TextStyle(fontSize: 12, color: AppColors.textMedium),
                  ),
                ],
              ),
            ),

          // Discount
          if (item.discount != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                item.discount!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.statusError,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          const SizedBox(height: 8),

          // Actions row: Catatan | Diskon | Hapus — Quantity
          Row(
            children: [
              // Catatan
              _buildTextActionButton(
                icon: Icons.receipt_outlined,
                label: 'Catatan',
                color: AppColors.textMedium,
              ),
              _buildDividerSeparator(),
              // Diskon
              _buildTextActionButton(
                icon: Icons.local_offer_outlined,
                label: 'Diskon',
                color: AppColors.textMedium,
              ),
              _buildDividerSeparator(),
              // Hapus
              _buildTextActionButton(
                icon: Icons.delete_outline,
                label: 'Hapus',
                color: AppColors.statusError,
              ),
              const Spacer(),
              // Quantity controls
              _buildQuantityControl(item.quantity),
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
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildDividerSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(width: 1, height: 12, color: AppColors.borderLight),
    );
  }

  Widget _buildQuantityControl(int quantity) {
    return Row(
      children: [
        _buildQuantityButton(Icons.remove, onTap: () {}),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ),
        _buildQuantityButton(Icons.add, onTap: () {}),
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

  Widget _buildFooter() {
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
                const Icon(Icons.keyboard_arrow_up_rounded,
                    size: 20, color: AppColors.textDark),
                const SizedBox(width: 4),
                const Text(
                  'Total (3 items)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Rp 92.000',
                  style: TextStyle(
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
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFooterButton(
                    label: 'Simpan',
                    backgroundColor: AppColors.buttonSave,
                    textColor: Colors.white,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
    double height = 38,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
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
    );
  }
}
