import 'package:flutter/material.dart';
import 'package:pos/features/home/presentation/widgets/nav_item.dart';
import 'package:pos/features/pos/presentation/pos_page_view.dart';
import 'package:pos/generated/assets.gen.dart';
import 'package:pos/generated/colors.gen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => __HomeViewState();
}

class __HomeViewState extends State<_HomeView> {
  int _navIndexSelected = 0;

  final _navViews = <Widget>[const PosPageView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildNavSidebar(),
          Expanded(child: _navViews[_navIndexSelected]),
        ],
      ),
    );
  }

  Widget _buildNavSidebar() {
    const navWidth = 80.0;

    final navItems = [
      (assetPath: Assets.icons.icPos.keyName, label: 'POS'),
      (assetPath: Assets.icons.icReceipt.keyName, label: 'Transaksi'),
      (assetPath: Assets.icons.icProduct.keyName, label: 'Produk'),
      (assetPath: Assets.icons.icCustomer.keyName, label: 'Pelanggan'),
      (assetPath: Assets.icons.icGraph.keyName, label: 'Shift'),
      (assetPath: Assets.icons.icMoneyStack.keyName, label: 'Kas'),
      (assetPath: Assets.icons.icReport.keyName, label: 'Laporan'),
    ];

    return Container(
      width: navWidth,
      height: double.infinity,
      color: AppColors.primary,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo area
          Container(
            width: navWidth,
            height: navWidth,
            alignment: Alignment.center,
            child: Assets.icons.icLunaposLogo.svg(width: 32, height: 32),
          ),
          Divider(height: 1, color: Colors.white, thickness: 1),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Main navigation items
                  for (int i = 0; i < navItems.length; i++)
                    NavItemWidget(
                      assetPath: navItems[i].assetPath,
                      label: navItems[i].label,
                      isActive: _navIndexSelected == i,
                      onTap: () {
                        // Only POS is implemented for now
                        if (i == 0) setState(() => _navIndexSelected = 0);
                      },
                    ),
                ],
              ),
            ),
          ),

          Container(
            color: AppColors.primary.withAlpha(100),
            child: Column(
              children: [
                NavIconItem(icon: Icons.account_circle, onTap: () {}),
                const Divider(
                  color: Colors.white24,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                NavIconItem(icon: Icons.settings, onTap: () {}),
                const Divider(
                  color: Colors.white24,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                NavIconItem(icon: Icons.logout, onTap: () {}),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // Bottom icons
        ],
      ),
    );
  }
}
