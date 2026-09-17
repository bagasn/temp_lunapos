import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/features/auth/login_pos/presentation/select_user/bloc/select_pos_user_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/widgets/widgets/text_field/search_text_field.dart';

class LoginPosUserPage extends StatelessWidget {
  const LoginPosUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SelectPosUserBloc>()..add(const FetchPosUsers()),
      child: const _LoginPosUserView(),
    );
  }
}

class _LoginPosUserView extends StatelessWidget {
  const _LoginPosUserView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: _buildHeader(context),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: TextButton.icon(
                  onPressed: () {
                    // TODO: implement change outlet
                  },
                  icon: const Icon(Icons.store_outlined, color: Colors.white),
                  label: const Text(
                    'Change Outlet',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchTextField(
              hintText: 'Cari User',
              onSearch: (_, keyword) {
                context.read<SelectPosUserBloc>().add(SearchPosUsers(keyword));
              },
            ),
          ),
          const SizedBox(height: 8),
          const Expanded(child: _UserGrid()),
        ],
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo / brand text
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'LUNA',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'POS',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Outlet name (placeholder)
        Text(
          'MEKDI JAKARTA',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.75),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        // Page title
        const Text(
          'Pilih User',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

// Change Outlet button — pinned to the right
// Positioned(
//   right: 0,
//   top: 0,
//   child: TextButton.icon(
//     onPressed: () {
//       // TODO: implement change outlet
//     },
//     icon: const Icon(Icons.store_outlined, color: Colors.white),
//     label: const Text(
//       'Change Outlet',
//       style: TextStyle(
//         fontFamily: 'Inter',
//         color: Colors.white,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//   ),
// ),

// ─── User Grid ─────────────────────────────────────────────────────────────

class _UserGrid extends StatelessWidget {
  const _UserGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectPosUserBloc, SelectPosUserState>(
      builder: (context, state) {
        if (state is SelectPosUserLoading || state is SelectPosUserInitial) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (state is SelectPosUserError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 16,
              ),
            ),
          );
        }

        if (state is SelectPosUserLoaded) {
          final users = state.filteredUsers;

          if (users.isEmpty) {
            return Center(
              child: Text(
                'User tidak ditemukan',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 16,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: users
                  .map(
                    (user) => _UserCard(
                      userId: user.id,
                      name: user.fullName ?? user.firstName ?? 'User',
                    ),
                  )
                  .toList(),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// ─── User Card ───────────────────────────────────────────────────────────────

class _UserCard extends StatelessWidget {
  final String userId;
  final String name;

  const _UserCard({required this.userId, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.white.withValues(alpha: 0.1),
          highlightColor: Colors.white.withValues(alpha: 0.06),
          onTap: () {
            context.go(
              AppRoutePaths.loginPosInputPin.path,
              extra: <String, String>{'userId': userId, 'fullName': name},
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar circle
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 12),
                // Name
                Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
