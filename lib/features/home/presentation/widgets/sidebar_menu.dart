import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_colors.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      color: AppColorConstants.surfaceSidebar,
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColorConstants.primaryPurpleLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'L',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 16),
          _SidebarItem(
            icon: Icons.point_of_sale_rounded,
            label: 'Kasir',
            isActive: true,
            onTap: () {},
          ),
          _SidebarItem(
            icon: Icons.inventory_2_outlined,
            label: 'Produk',
            onTap: () {},
          ),
          _SidebarItem(
            icon: Icons.receipt_long_outlined,
            label: 'Riwayat',
            onTap: () {},
          ),
          _SidebarItem(
            icon: Icons.bar_chart_rounded,
            label: 'Laporan',
            onTap: () {},
          ),
          const Spacer(),
          _SidebarItem(
            icon: Icons.sync_rounded,
            label: 'Sync',
            onTap: () {},
          ),
          _SidebarItem(
            icon: Icons.settings_outlined,
            label: 'Setting',
            onTap: () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Tooltip(
        message: label,
        preferBelow: false,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColorConstants.primaryPurple
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: isActive
                  ? Colors.white
                  : Colors.white.withAlpha(153),
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
