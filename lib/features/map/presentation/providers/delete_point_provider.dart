import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/domain/usecases/delete_point_usecase.dart';
import 'package:land_survey/features/map/presentation/providers/map_data_state.dart';

import 'get_point_provider.dart';

class DeletePointsNotifier extends StateNotifier<MapDataState> {
  DeletePointsNotifier(this._deletePointUseCase, this._ref)
      : super(MapDataState.initial());

  final DeletePointUseCase _deletePointUseCase;
  final Ref _ref;

  Future<void> getPoints(int index) async {
    final value = await _deletePointUseCase.call(index);
    state = value.fold((l) {
      return state.copyWith(isLoading: false);
    }, (r) {
      return state.copyWith(
        isLoading: false,
      );
    });
    await _ref.read(getPointsProvider.notifier).getPoints();
  }
}

final deletePointsProvider =
    StateNotifierProvider<DeletePointsNotifier, MapDataState>((ref) {
  final useCase = ref.read(deletePointUseCaseProvider);
  return DeletePointsNotifier(useCase, ref);
});
