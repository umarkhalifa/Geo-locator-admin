import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/domain/usecases/delet_firestore_points.dart';
import 'package:land_survey/features/map/presentation/providers/map_data_state.dart';

class DeletePointsNotifier extends StateNotifier<MapDataState> {
  DeletePointsNotifier(this._deletePointUseCase, this._ref)
      : super(MapDataState.initial());

  final DeleteFireStorePointUseCase _deletePointUseCase;
  final Ref _ref;

  Future<void> getPoints(int index) async {
    final value = await _deletePointUseCase.call(index);
    // state = value.fold((l) {
    //   return state.copyWith(isLoading: false);
    // }, (r) {
    //   return state.copyWith(
    //     isLoading: false,
    //   );
    // });
    // await _ref.read(getFirePointsProvider.notifier).getPoints();
  }
}

final deletePointsProvider =
    StateNotifierProvider<DeletePointsNotifier, MapDataState>((ref) {
  final useCase = ref.read(deleteFirestorePointsUseCaseProvider);
  return DeletePointsNotifier(useCase, ref);
});
