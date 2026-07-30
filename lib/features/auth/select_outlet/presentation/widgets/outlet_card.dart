import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/outlet_entity.dart';

class OutletCard extends StatelessWidget {
  final OutletEntity outlet;
  final VoidCallback onTap;
  final bool isSelected;

  const OutletCard({
    super.key,
    required this.outlet,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withAlpha(51)
                : Colors.white.withAlpha(26),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Colors.white.withAlpha(204)
                  : Colors.white.withAlpha(77),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Outlet Avatar
              _buildAvatar(),
              const SizedBox(width: 16),
              // Outlet Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      outlet.outletName,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColorConstants.textWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      outlet.companyName,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withAlpha(179),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final pictureUrl = outlet.outletPictureUrl;
    if (pictureUrl != null && pictureUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: CachedNetworkImage(
          imageUrl: pictureUrl,
          width: 52,
          height: 52,
          fit: BoxFit.cover,
          placeholder: (ctx, url) => _defaultAvatar(),
          errorWidget: (ctx, url, err) => _defaultAvatar(),
        ),
      );
    }
    return _defaultAvatar();
  }

  Widget _defaultAvatar() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          outlet.outletName.isNotEmpty
              ? outlet.outletName[0].toUpperCase()
              : 'O',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColorConstants.textWhite,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
