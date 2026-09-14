import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItemWidget extends StatelessWidget {
  const NavItemWidget({
    super.key,
    required this.assetPath,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final String assetPath;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconSize = 28.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.black.withValues(alpha: 0.25)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              assetPath,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(
                isActive ? Colors.white : Colors.white.withValues(alpha: 0.7),
                BlendMode.srcATop,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.7),
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NavIconItem extends StatelessWidget {
  const NavIconItem({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 28),
      ),
    );
  }
}
