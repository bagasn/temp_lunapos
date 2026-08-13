import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/auth/select_outlet/presentation/bloc/auth_outlet_bloc.dart';
import 'package:pos/features/auth/select_outlet/presentation/bloc/auth_outlet_event.dart';
import 'package:pos/features/auth/select_outlet/presentation/bloc/auth_outlet_state.dart';
import 'package:pos/features/auth/select_outlet/presentation/widgets/outlet_card.dart';
import 'package:pos/shared/widgets/dialog/confirmation_dialog.dart';

class SelectOutletPage extends StatelessWidget {
  const SelectOutletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AuthOutletBloc>(),
      child: BlocListener<AuthOutletBloc, AuthOutletState>(
        listener: (context, state) {
          if (state is AuthOutletTokenSuccess) {
            context.go(AppRoutePaths.home.path);
          }
        },
        child: const _SelectOutletView(),
      ),
    );
  }
}

class _SelectOutletView extends StatelessWidget {
  const _SelectOutletView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthOutletBloc, AuthOutletState>(
      listener: (context, state) {
        if (state is AuthOutletTokenFetching) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColorConstants.primaryPurpleDark,
                AppColorConstants.backgroundPurple,
                AppColorConstants.primaryPurpleLight,
              ],
            ),
          ),
          child: Column(
            children: [
              _buildHeader(context),
              _buildSearchBar(context),
              Expanded(child: _buildOutletList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        children: [
          // Logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'L',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColorConstants.primaryPurple,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'PILIH OUTLET',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          // Logout button
          IconButton(
            onPressed: () async {
              final confirm = await showConfirmationDialog(
                context: context,
                message: 'Anda akan keluar. Lanjutkan?',
              );
              if (confirm != true) return;

              await locator<SessionManager>().clearSession();
              if (context.mounted) {
                context.go(AppRoutePaths.login.path);
              }
            },
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            tooltip: 'Log Out',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(38),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withAlpha(77)),
        ),
        child: TextField(
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColorConstants.textWhite,
          ),
          decoration: InputDecoration(
            hintText: 'Cari Outlet',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withAlpha(153),
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.white.withAlpha(179),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onChanged: (v) =>
              context.read<AuthOutletBloc>().add(AuthOutletSearchChanged(v)),
        ),
      ),
    );
  }

  Widget _buildOutletList() {
    return BlocBuilder<AuthOutletBloc, AuthOutletState>(
      builder: (context, state) {
        if (state is AuthOutletInitial || state is AuthOutletFetching) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        if (state is AuthOutletDataState) {
          if (state.outlets.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.store_mall_directory_outlined,
                    color: Colors.white.withAlpha(153),
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Outlet tidak ditemukan',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white.withAlpha(179),
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            itemCount: state.outlets.length,
            itemBuilder: (ctx, i) {
              final outlet = state.outlets[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OutletCard(
                  outlet: outlet,
                  onTap: () => context.read<AuthOutletBloc>().add(
                    AuthOutletSelected(outlet),
                  ),
                ),
              );
            },
          );
        }
        if (state is AuthOutletTokenFetching) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Memilih outlet...',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }
        if (state is AuthOutletFailure) {
          return Center(
            child: Text(
              state.error.errorMessage,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
