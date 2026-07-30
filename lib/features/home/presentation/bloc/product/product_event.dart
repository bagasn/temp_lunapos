import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

final class ProductsLoadRequested extends ProductEvent {
  const ProductsLoadRequested();
}

final class ProductSearchChanged extends ProductEvent {
  final String keyword;
  const ProductSearchChanged(this.keyword);
  @override
  List<Object?> get props => [keyword];
}

final class ProductCategoryFilterChanged extends ProductEvent {
  final String? categoryId; // null = all
  const ProductCategoryFilterChanged(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}
