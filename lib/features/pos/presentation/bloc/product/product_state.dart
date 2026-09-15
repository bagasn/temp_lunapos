import 'package:equatable/equatable.dart';
import 'package:pos/features/pos/domain/entities/product_entity.dart';

enum PosProductStatus { initial, loading, success, failure }

class PosProductState extends Equatable {
  final PosProductStatus status;
  final List<PosProductEntity> products;
  final bool hasReachedMax;
  final String? errorMessage;
  final int currentPage;

  const PosProductState({
    required this.status,
    required this.products,
    required this.hasReachedMax,
    this.errorMessage,
    required this.currentPage,
  });

  const PosProductState.initial()
      : status = PosProductStatus.initial,
        products = const [],
        hasReachedMax = false,
        errorMessage = null,
        currentPage = 0;

  PosProductState copyWith({
    PosProductStatus? status,
    List<PosProductEntity>? products,
    bool? hasReachedMax,
    String? errorMessage,
    int? currentPage,
  }) {
    return PosProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    products,
    hasReachedMax,
    errorMessage,
    currentPage,
  ];
}
