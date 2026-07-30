import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_event.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_state.dart';
import 'package:pos/shared/widgets/widgets/luna_button.dart';
import 'package:pos/shared/widgets/widgets/luna_text_field.dart';

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
  bool _isAuthKeyMode = false;

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
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          widget.onLoginSuccess(state);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return Container(
          color: AppColorConstants.backgroundWhite,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                // Welcome text
                Text(
                  'Selamat Datang',
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColorConstants.primaryPurple,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Sahabat LUNA! 👋',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColorConstants.textMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masuk ke akun Anda untuk memulai penjualan.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColorConstants.textLight,
                  ),
                ),
                const SizedBox(height: 40),

                // Toggle: Email / Auth Key
                Row(
                  children: [
                    _buildToggleTab('Email', !_isAuthKeyMode),
                    const SizedBox(width: 8),
                    _buildToggleTab('Auth Key', _isAuthKeyMode),
                  ],
                ),
                const SizedBox(height: 24),

                // Email/Auth key field
                LunaTextField(
                  label: _isAuthKeyMode ? 'Authentication Key' : 'Email',
                  hint: _isAuthKeyMode ? 'Masukkan auth key...' : 'Cth: joe@mail.com',
                  controller: _emailController,
                  keyboardType: _isAuthKeyMode
                      ? TextInputType.text
                      : TextInputType.emailAddress,
                  prefixIcon: Icon(
                    _isAuthKeyMode ? Icons.key_rounded : Icons.email_outlined,
                    color: AppColorConstants.textLight,
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Field ini wajib diisi';
                    return null;
                  },
                  enabled: !isLoading,
                ),
                const SizedBox(height: 20),

                // Password field (hide in auth key mode)
                if (!_isAuthKeyMode) ...[
                  LunaTextField(
                    label: 'Kata Sandi',
                    hint: 'Masukkan kata sandi',
                    controller: _passwordController,
                    isPassword: true,
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: AppColorConstants.textLight,
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Kata sandi wajib diisi';
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
                          color: AppColorConstants.primaryPurple,
                        ),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Error message
                if (state is LoginFailure)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColorConstants.statusError.withAlpha(25),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColorConstants.statusError.withAlpha(77),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColorConstants.statusError,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.message,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColorConstants.statusError,
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
                        color: AppColorConstants.textMedium,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Buat Akun Sekarang!',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColorConstants.primaryPurple,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColorConstants.primaryPurple,
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.help_outline, size: 16),
                      label: const Text('Butuh Bantuan?'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColorConstants.textLight,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: AppColorConstants.textLight,
                      ),
                      child: const Text('Client'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildToggleTab(String label, bool isActive) {
    return GestureDetector(
      onTap: () => setState(() => _isAuthKeyMode = label == 'Auth Key'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? AppColorConstants.primaryPurple
              : AppColorConstants.backgroundLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: isActive
                ? AppColorConstants.textWhite
                : AppColorConstants.textMedium,
          ),
        ),
      ),
    );
  }
}
