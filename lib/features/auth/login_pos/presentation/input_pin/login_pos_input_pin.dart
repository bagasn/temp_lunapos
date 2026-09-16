import 'package:flutter/material.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/widgets/widgets/pin_keyboard_widget.dart';

class LoginPosInputPinPage extends StatefulWidget {
  const LoginPosInputPinPage({super.key});

  @override
  State<LoginPosInputPinPage> createState() => _LoginPosInputPinPageState();
}

class _LoginPosInputPinPageState extends State<LoginPosInputPinPage> {
  static const int _pinLength = 4;

  /// Holds the number of digits entered so far (0–4).
  int _enteredDigits = 0;

  void _onKeyPressed(String key) {
    if (key == 'Hapus') {
      if (_enteredDigits > 0) {
        setState(() => _enteredDigits--);
      }
    } else {
      if (_enteredDigits < _pinLength) {
        setState(() => _enteredDigits++);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Row(
        children: [
          // ─── Left Panel: Avatar + PIN dots ───────────────────────────────
          Expanded(
            child: _LeftPanel(
              enteredDigits: _enteredDigits,
              pinLength: _pinLength,
            ),
          ),

          // ─── Vertical Divider ─────────────────────────────────────────────
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: Colors.white.withValues(alpha: 0.15),
          ),

          // ─── Right Panel: PIN Keyboard ────────────────────────────────────
          Expanded(child: PinKeyboardWidget(onKeyPressed: _onKeyPressed)),
        ],
      ),
    );
  }
}

class _LeftPanel extends StatelessWidget {
  final int enteredDigits;
  final int pinLength;

  const _LeftPanel({required this.enteredDigits, required this.pinLength});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Avatar circle
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.15),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 3,
            ),
          ),
          child: Icon(
            Icons.person,
            size: 90,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),

        const SizedBox(height: 24),

        // User name (placeholder)
        const Text(
          'Pos User',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 32),

        // PIN input boxes
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(pinLength, (index) {
            final isFilled = index < enteredDigits;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _PinBox(isFilled: isFilled),
            );
          }),
        ),
      ],
    );
  }
}

/// A single PIN input box — empty or filled indicator.
class _PinBox extends StatelessWidget {
  final bool isFilled;

  const _PinBox({required this.isFilled});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withValues(alpha: 0.10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: isFilled ? const Icon(Icons.circle, color: Colors.white) : null,
    );
  }
}
