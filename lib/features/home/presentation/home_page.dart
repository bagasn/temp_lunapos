import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/home/presentation/bloc/pos/pos_bloc.dart';
import 'package:pos/features/home/presentation/bloc/pos/pos_event.dart';
import 'package:pos/features/home/presentation/bloc/pos/pos_state.dart';
import 'package:pos/features/home/presentation/bloc/product/product_bloc.dart';
import 'package:pos/features/home/presentation/bloc/product/product_event.dart';
import 'package:pos/features/home/presentation/bloc/product/product_state.dart';
import 'package:pos/features/home/presentation/widgets/category_filter_bar.dart';
import 'package:pos/features/home/presentation/widgets/order_panel.dart';
import 'package:pos/features/home/presentation/widgets/product_grid.dart';
import 'package:pos/features/home/presentation/widgets/sidebar_menu.dart';
import 'package:pos/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:pos/features/sync/presentation/bloc/sync_event.dart';
import 'package:pos/features/sync/presentation/bloc/sync_state.dart';
import 'package:pos/features/sync/presentation/widgets/sync_progress_overlay.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ProductBloc>()),
        BlocProvider(
          create: (_) => getIt<PosBloc>()..add(const PosInitRequested()),
        ),
        BlocProvider(
          create: (_) =>
              getIt<SyncBloc>()..add(const SyncStarted(force: true)),
        ),
      ],
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SyncBloc, SyncState>(
      listener: (context, state) {
        if (state is SyncCompleted) {
          // Load products after sync completes
          context
              .read<ProductBloc>()
              .add(const ProductsLoadRequested());
        }
      },
      child: Scaffold(
        backgroundColor: AppColorConstants.backgroundLight,
        body: BlocListener<PosBloc, PosState>(
          listener: (context, state) {
            if (state is PosPaid) {
              // Start fresh order after payment
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pembayaran berhasil! Terima kasih.'),
                  backgroundColor: AppColorConstants.statusSuccess,
                ),
              );
              context.read<PosBloc>().add(const PosNewOrderStarted());
            }
            if (state is PosSaved) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order berhasil disimpan.'),
                  backgroundColor: AppColorConstants.statusInfo,
                ),
              );
              context.read<PosBloc>().add(const PosNewOrderStarted());
            }
          },
          child: Stack(
            children: [
              Row(
                children: [
                  // 1. Sidebar
                  const SidebarMenu(),
                  // 2. Product Panel
                  Expanded(child: _ProductPanel()),
                  // 3. Order Panel
                  const OrderPanel(),
                ],
              ),
              // Sync overlay on top
              const SyncProgressOverlay(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductPanel extends StatelessWidget {
  final _searchController = TextEditingController();

  _ProductPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toolbar
        Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            color: AppColorConstants.backgroundWhite,
            border: Border(
              bottom: BorderSide(color: AppColorConstants.borderLight),
            ),
          ),
          child: Row(
            children: [
              // Search
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => context
                      .read<ProductBloc>()
                      .add(ProductSearchChanged(v)),
                  decoration: InputDecoration(
                    hintText: 'Cari Nama/SKU Produk',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColorConstants.textLight,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColorConstants.borderLight,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColorConstants.borderLight,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColorConstants.primaryPurple,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColorConstants.surfaceInput,
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Sync button
              BlocBuilder<SyncBloc, SyncState>(
                builder: (context, state) {
                  if (state is SyncInProgress) {
                    return const SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColorConstants.primaryPurple,
                      ),
                    );
                  }
                  return IconButton(
                    onPressed: () => context
                        .read<SyncBloc>()
                        .add(const SyncStarted(force: true)),
                    icon: const Icon(
                      Icons.sync_rounded,
                      color: AppColorConstants.primaryPurple,
                    ),
                    tooltip: 'Sinkronisasi data',
                  );
                },
              ),
            ],
          ),
        ),

        // Category filter
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CategoryFilterBar(
                  categories: state.categories,
                  selectedCategoryId: state.selectedCategoryId,
                  onCategorySelected: (id) => context
                      .read<ProductBloc>()
                      .add(ProductCategoryFilterChanged(id)),
                ),
              );
            }
            return const SizedBox(height: 48);
          },
        ),

        // Product grid
        Expanded(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColorConstants.primaryPurple,
                  ),
                );
              }
              if (state is ProductLoaded) {
                if (state.filteredProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: AppColorConstants.textLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Produk tidak ditemukan',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColorConstants.textLight,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ProductGrid(
                  products: state.filteredProducts,
                  onProductTap: (product) =>
                      context.read<PosBloc>().add(PosProductAdded(product)),
                );
              }
              if (state is ProductError) {
                return Center(
                  child: Text(
                    state.message,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColorConstants.statusError,
                    ),
                  ),
                );
              }
              // Initial state while sync is happening
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: AppColorConstants.primaryPurple,
                    ),
                    SizedBox(height: 16),
                    Text('Memuat produk...'),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
