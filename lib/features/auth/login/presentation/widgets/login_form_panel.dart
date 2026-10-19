import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_event.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_state.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/auth/login/presentation/widgets/luna_button.dart';
import 'package:pos/features/auth/login/presentation/widgets/luna_text_field.dart';

class LoginFormPanel extends StatefulWidget {
  final void Function(LoginSuccess state) onLoginSuccess;

  const LoginFormPanel({super.key, required this.onLoginSuccess});

  @override
  State<LoginFormPanel> createState() => _LoginFormPanelState();
}

class _LoginFormPanelState extends State<LoginFormPanel> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginBloc>().add(
      LoginSubmitted(
        username: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext mContext) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          widget.onLoginSuccess(state);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Selamat Datang Sahabat LUNA! 👋',
                        style: TextStyle(
                          color: AppColors.charcoal800,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'MASUK',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),

                      SizedBox(height: 28),

                      // Email/Auth key field
                      LunaTextField(
                        label: 'Email',
                        hint: 'Cth: joe@mail.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Field ini wajib diisi';
                          }
                          return null;
                        },
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 20),

                      LunaTextField(
                        label: 'Kata Sandi',
                        hint: 'Masukkan kata sandi',
                        controller: _passwordController,
                        isPassword: true,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Kata sandi wajib diisi';
                          }
                          return null;
                        },
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Lupa Password?',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Error message
                      if (state is LoginFailure)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.statusError.withAlpha(25),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.statusError.withAlpha(77),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: AppColors.statusError,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  state.error.errorMessage,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.statusError,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 20),

                      // Sign In button
                      LunaButton(
                        label: 'Masuk',
                        isLoading: isLoading,
                        onPressed: () => _submit(context),
                      ),

                      const SizedBox(height: 16),

                      // Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belum punya akun? ',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textMedium,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Buat Akun Sekarang!',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.charcoal200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.help_outline, size: 16),
                    label: const Text('Butuh Bantuan?'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
