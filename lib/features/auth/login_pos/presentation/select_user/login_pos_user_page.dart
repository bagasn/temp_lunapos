import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/generated/colors.gen.dart';

class LoginPosUserPage extends StatefulWidget {
  const LoginPosUserPage({super.key});

  @override
  State<LoginPosUserPage> createState() => _LoginPosUserPageState();
}

class _LoginPosUserPageState extends State<LoginPosUserPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  /// Placeholder user list — will be replaced by real data in a later step.
  static const List<String> _dummyUsers = [
    'Asis 2',
    'Asis Lunapos cuy',
    'TestTokok Lunas',
    'Tokojer',
    'Tokoluna Test',
  ];

  List<String> get _filteredUsers {
    if (_searchQuery.isEmpty) return _dummyUsers;
    return _dummyUsers
        .where((u) => u.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          const SizedBox(height: 8),
          Expanded(child: _buildUserGrid()),
        ],
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center content
          Column(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
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
          ),

          // Change Outlet button — pinned to the right
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
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Search Bar ────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: 'Cari User',
            hintStyle: TextStyle(
              fontFamily: 'Inter',
              color: Colors.black.withValues(alpha: 0.4),
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.black.withValues(alpha: 0.5),
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.cancel_rounded,
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                : null,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onChanged: (v) => setState(() => _searchQuery = v),
        ),
      ),
    );
  }

  // ─── User Grid ─────────────────────────────────────────────────────────────

  Widget _buildUserGrid() {
    final users = _filteredUsers;

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
        children: users.map((name) => _UserCard(name: name)).toList(),
      ),
    );
  }
}

// ─── User Card ───────────────────────────────────────────────────────────────

class _UserCard extends StatelessWidget {
  final String name;

  const _UserCard({required this.name});

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
            context.go(AppRoutePaths.loginPosInputPin.path);
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
