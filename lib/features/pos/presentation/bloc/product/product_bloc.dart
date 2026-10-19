import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/pos/domain/usecases/get_pos_products_usecase.dart';
import 'package:pos/features/pos/presentation/bloc/product/product_event.dart';
import 'package:pos/features/pos/presentation/bloc/product/product_state.dart';

const _pageSize = 20;

@injectable
class PosProductBloc extends Bloc<PosProductEvent, PosProductState> {
  final GetPosProductsUseCase _getPosProductsUseCase;

  PosProductBloc(this._getPosProductsUseCase)
      : super(const PosProductState.initial()) {
    on<FetchPosProducts>(_onFetchPosProducts);
    on<RefreshPosProducts>(_onRefreshPosProducts);
  }

  Future<void> _onFetchPosProducts(
    FetchPosProducts event,
    Emitter<PosProductState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: PosProductStatus.loading));

    final result = await _getPosProductsUseCase(
      GetPosProductsParams(
        limit: _pageSize,
        offset: state.products.length,
        searchQuery: event.searchQuery,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PosProductStatus.failure,
          errorMessage: failure.errorMessage,
        ),
      ),
      (newProducts) => emit(
        state.copyWith(
          status: PosProductStatus.success,
          products: List.of(state.products)..addAll(newProducts),
          hasReachedMax: newProducts.length < _pageSize,
          currentPage: state.currentPage + 1,
        ),
      ),
    );
  }

  Future<void> _onRefreshPosProducts(
    RefreshPosProducts event,
    Emitter<PosProductState> emit,
  ) async {
    emit(const PosProductState.initial());
    add(FetchPosProducts(searchQuery: event.searchQuery));
  }
}
