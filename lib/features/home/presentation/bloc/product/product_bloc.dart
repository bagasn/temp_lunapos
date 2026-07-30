import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/home/domain/entities/product_entity.dart';
import 'package:pos/features/home/domain/usecases/get_products_usecase.dart';
import 'package:pos/features/home/presentation/bloc/product/product_event.dart';
import 'package:pos/features/home/presentation/bloc/product/product_state.dart';
import 'package:pos/shared/domain/usecases/usecase.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  List<ProductEntity> _allProducts = [];

  ProductBloc(this._getProductsUseCase, this._getCategoriesUseCase)
      : super(const ProductInitial()) {
    on<ProductsLoadRequested>(_onLoad);
    on<ProductSearchChanged>(_onSearch);
    on<ProductCategoryFilterChanged>(_onCategoryFilter);
  }

  Future<void> _onLoad(
    ProductsLoadRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    final productsResult = await _getProductsUseCase(const NoParams());
    final categoriesResult = await _getCategoriesUseCase(const NoParams());

    productsResult.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) {
        _allProducts = products;
        final categories = categoriesResult.fold(
          (_) => <CategoryEntity>[],
          (cats) => cats,
        );
        emit(ProductLoaded(
          allProducts: products,
          filteredProducts: products,
          categories: categories,
        ));
      },
    );
  }

  void _onSearch(
    ProductSearchChanged event,
    Emitter<ProductState> emit,
  ) {
    final current = state;
    if (current is! ProductLoaded) return;
    final keyword = event.keyword.toLowerCase();
    final filtered = keyword.isEmpty
        ? _applyCategory(_allProducts, current.selectedCategoryId)
        : _applyCategory(_allProducts, current.selectedCategoryId)
            .where((p) => p.name.toLowerCase().contains(keyword))
            .toList();
    emit(ProductLoaded(
      allProducts: _allProducts,
      filteredProducts: filtered,
      categories: current.categories,
      selectedCategoryId: current.selectedCategoryId,
      keyword: event.keyword,
    ));
  }

  void _onCategoryFilter(
    ProductCategoryFilterChanged event,
    Emitter<ProductState> emit,
  ) {
    final current = state;
    if (current is! ProductLoaded) return;
    final filtered = _applyCategory(_allProducts, event.categoryId);
    emit(ProductLoaded(
      allProducts: _allProducts,
      filteredProducts: filtered,
      categories: current.categories,
      selectedCategoryId: event.categoryId,
      keyword: current.keyword,
    ));
  }

  List<ProductEntity> _applyCategory(
    List<ProductEntity> products,
    String? categoryId,
  ) {
    if (categoryId == null) return products;
    if (categoryId == 'favorites') {
      return products.where((p) => p.isFavorite).toList();
    }
    // NOTE: Category filtering requires productToCategory relation from Firestore.
    // For now, return all (can be enhanced later)
    return products;
  }
}
