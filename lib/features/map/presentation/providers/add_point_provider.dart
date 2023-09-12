import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/domain/usecases/add_firestore_points.dart';
import 'package:land_survey/features/map/presentation/providers/map_data_state.dart';

class AddPointsNotifier extends StateNotifier<MapDataState> {
  AddPointsNotifier(this._addPointUseCase)
      : super(MapDataState.initial());

  final AddFirestorePointUseCase _addPointUseCase;

  Future<void> addPoint(LocationPoint locationPoint) async {
    state = state.copyWith(isLoading: true);
    final value = await _addPointUseCase.call(AddFirestoreParams(
        locationPoint.latitude,
        locationPoint.longitude,
        locationPoint.northing,
        locationPoint.easting,
        locationPoint.zone,
        locationPoint.band,
        locationPoint.name,
        locationPoint.height));
    state = value.fold((l) {
      return state.copyWith(isLoading: false);
    }, (r) {
      return state.copyWith(
        isLoading: false,
      );
    });
    // await _ref.read(getPointsProvider.notifier).getPoints();
  }
}

final addPointsProvider =
    StateNotifierProvider<AddPointsNotifier, MapDataState>((ref) {
  final useCase = ref.read(addFirestorePointsUseCaseProvider);
  return AddPointsNotifier(useCase);
});
