import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:toastification/toastification.dart';

enum PopupType { info, success, warning, error }

@singleton
class PopupService {
  Toastification? _toaster;

  Toastification get toaster {
    _toaster ??= Toastification();
    return _toaster!;
  }

  Future<ToastificationItem> show(
    BuildContext context, {
    required String message,
    PopupType type = PopupType.info,
  }) async {
    return toaster.showCustom(
      alignment: Alignment.topCenter,
      animationDuration: Duration(milliseconds: 200),
      autoCloseDuration: Duration(seconds: 3),
      builder: (context, holder) {
        return _buildSnackbar(type: type, message: message, toastItem: holder);
      },
    );
  }

  void dismissToast() {
    toaster.dismissAll(delayForAnimation: false);
  }

  Widget _buildSnackbar({
    required PopupType type,
    required String message,
    required ToastificationItem toastItem,
  }) {
    Color bgColor = Colors.grey;
    Color fgColor = Colors.white;

    IconData iconData = Icons.info;

    switch (type) {
      case PopupType.info:
        bgColor = Colors.blue.shade600;
        iconData = Icons.info;
        break;
      case PopupType.success:
        bgColor = AppColors.primaryPurple;
        iconData = Icons.check_circle;
        break;
      case PopupType.warning:
        bgColor = Colors.orange.shade400;
        iconData = Icons.warning;
        break;
      case PopupType.error:
        bgColor = Colors.red.shade600;
        iconData = Icons.cancel;
        break;
    }

    final textStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: fgColor,
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 12).copyWith(left: 12, right: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              spacing: 12,
              children: [
                Icon(iconData, color: fgColor, size: 32),
                Expanded(
                  child: RichText(
                    maxLines: 3,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(text: message, style: textStyle),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              toaster.dismissById(toastItem.id);
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(6),
              child: Icon(Icons.close, color: fgColor, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
