import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:pos/features/auth/login/presentation/bloc/login_state.dart';
import 'package:pos/features/auth/login/presentation/widgets/login_form_panel.dart';
import 'package:pos/features/auth/login/presentation/widgets/login_left_panel.dart';
import 'package:pos/features/auth/select_outlet/presentation/bloc/select_outlet_bloc.dart';
import 'package:pos/features/auth/select_outlet/presentation/bloc/select_outlet_event.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginBloc>()),
        BlocProvider(create: (_) => getIt<SelectOutletBloc>()),
      ],
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          if (isWide) {
            return Row(
              children: [
                Expanded(child: const LoginLeftPanel()),
                Expanded(
                  child: LoginFormPanel(
                    onLoginSuccess: (state) => _onSuccess(context, state),
                  ),
                ),
              ],
            );
          }
          // Mobile: stack form only
          return LoginFormPanel(
            onLoginSuccess: (state) => _onSuccess(context, state),
          );
        },
      ),
    );
  }

  void _onSuccess(BuildContext context, LoginSuccess state) {
    context.read<SelectOutletBloc>().add(OutletsLoaded(state.outlets));
    context.go(AppRoutePaths.selectOutlet.path);
  }
}
