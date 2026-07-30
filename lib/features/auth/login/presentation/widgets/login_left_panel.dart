import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';

class LoginLeftPanel extends StatelessWidget {
  const LoginLeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColorConstants.primaryPurpleDark,
            AppColorConstants.primaryPurple,
            AppColorConstants.backgroundPurple,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background decorative circles
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(13),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(13),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(8),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                _buildLogo(),
                const SizedBox(height: 48),
                // Tagline
                Text(
                  'Satu Aplikasi Kasir',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColorConstants.textWhite,
                    height: 1.2,
                  ),
                ),
                Text(
                  'untuk Semua Jenis Usaha',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColorConstants.textWhite.withAlpha(230),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '#UntungadaLUNA',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: Colors.white.withAlpha(179),
                  ),
                ),
                const SizedBox(height: 48),
                // Feature chips
                _buildFeatureChip(Icons.point_of_sale_rounded, 'Point of Sales'),
                const SizedBox(height: 12),
                _buildFeatureChip(Icons.inventory_2_rounded, 'Manajemen Stok'),
                const SizedBox(height: 12),
                _buildFeatureChip(Icons.bar_chart_rounded, 'Laporan Penjualan'),
                const SizedBox(height: 12),
                _buildFeatureChip(Icons.receipt_long_rounded, 'Cetak Struk'),
                const Spacer(),
                // Copyright
                Text(
                  '© 2022 - PT LUNA Aplikasi Indonesia',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withAlpha(128),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(51),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'L',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColorConstants.primaryPurple,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Luna POS',
          style: AppTextStyles.headlineLarge.copyWith(
            color: AppColorConstants.textWhite,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white.withAlpha(204),
          ),
        ),
      ],
    );
  }
}
