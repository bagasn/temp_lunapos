import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/features/auth/login_pos/presentation/input_pin/bloc/login_pos_user_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/widgets/widgets/pin_keyboard_widget.dart';

class LoginPosInputPinPage extends StatelessWidget {
  final String userId;
  final String fullName;

  const LoginPosInputPinPage({
    super.key,
    required this.userId,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<LoginPosUserBloc>(),
      child: _LoginPosInputPinView(userId: userId, fullName: fullName),
    );
  }
}

class _LoginPosInputPinView extends StatefulWidget {
  final String userId;
  final String fullName;

  const _LoginPosInputPinView({required this.userId, required this.fullName});

  @override
  State<_LoginPosInputPinView> createState() => _LoginPosInputPinViewState();
}

class _LoginPosInputPinViewState extends State<_LoginPosInputPinView> {
  static const int _pinLength = 4;

  /// Accumulates the actual digit characters (max 4).
  String _pin = '';

  void _onKeyPressed(String key) {
    if (key == 'Hapus') {
      if (_pin.isNotEmpty) {
        setState(() => _pin = _pin.substring(0, _pin.length - 1));
      }
    } else {
      if (_pin.length < _pinLength) {
        final newPin = _pin + key;
        setState(() => _pin = newPin);

        // Auto-submit when 4 digits are entered
        if (newPin.length == _pinLength) {
          context.read<LoginPosUserBloc>().add(
            VerifyPinEvent(userId: widget.userId, pin: newPin),
          );
        }
      }
    }
  }

  void _resetPin() {
    setState(() => _pin = '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginPosUserBloc, LoginPosUserState>(
      listener: (context, state) {
        if (state is LoginPosUserSuccess) {
          context.go(AppRoutePaths.home.path);
        } else if (state is LoginPosUserError) {
          _resetPin();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.primary,
              body: Row(
                children: [
                  // ─── Left Panel: Avatar + PIN dots ──────────────────────────
                  Expanded(
                    child: _LeftPanel(
                      fullName: widget.fullName,
                      enteredDigits: _pin.length,
                      pinLength: _pinLength,
                    ),
                  ),

                  // ─── Vertical Divider ────────────────────────────────────────
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),

                  // ─── Right Panel: PIN Keyboard ───────────────────────────────
                  Expanded(
                    child: PinKeyboardWidget(onKeyPressed: _onKeyPressed),
                  ),
                ],
              ),
            ),

            // ─── Full-screen Loading Overlay ───────────────────────────────────
            if (state is LoginPosUserLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ─── Left Panel ──────────────────────────────────────────────────────────────

class _LeftPanel extends StatelessWidget {
  final String fullName;
  final int enteredDigits;
  final int pinLength;

  const _LeftPanel({
    required this.fullName,
    required this.enteredDigits,
    required this.pinLength,
  });

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

        // User name — dynamic
        Text(
          fullName.isNotEmpty ? fullName : 'POS User',
          style: const TextStyle(
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
