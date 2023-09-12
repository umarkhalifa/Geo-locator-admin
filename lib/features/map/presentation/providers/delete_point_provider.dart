import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/domain/usecases/delet_firestore_points.dart';
import 'package:land_survey/features/map/presentation/providers/map_data_state.dart';

class DeletePointsNotifier extends StateNotifier<MapDataState> {
  DeletePointsNotifier(this._deletePointUseCase)
      : super(MapDataState.initial());

  final DeleteFireStorePointUseCase _deletePointUseCase;

  Future<void> getPoints(int index) async {
    await _deletePointUseCase.call(index);
    state = state.copyWith(isLoading: false);
  }
}

final deletePointsProvider =
    StateNotifierProvider<DeletePointsNotifier, MapDataState>((ref) {
  final useCase = ref.read(deleteFirestorePointsUseCaseProvider);
  return DeletePointsNotifier(useCase);
});
