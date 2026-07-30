import 'package:equatable/equatable.dart';
import 'package:pos/features/home/domain/entities/product_entity.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class ProductLoading extends ProductState {
  const ProductLoading();
}

final class ProductLoaded extends ProductState {
  final List<ProductEntity> allProducts;
  final List<ProductEntity> filteredProducts;
  final List<CategoryEntity> categories;
  final String? selectedCategoryId;
  final String keyword;

  const ProductLoaded({
    required this.allProducts,
    required this.filteredProducts,
    required this.categories,
    this.selectedCategoryId,
    this.keyword = '',
  });

  @override
  List<Object?> get props => [
        allProducts,
        filteredProducts,
        categories,
        selectedCategoryId,
        keyword,
      ];
}

final class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object?> get props => [message];
}
