import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/domain/usecases/get_points_usecase.dart';
import 'package:land_survey/features/map/presentation/providers/map_data_state.dart';

class GetPointsNotifier extends StateNotifier<MapDataState> {
  GetPointsNotifier(this._getPointUseCase) : super(MapDataState.initial()) {
    getPoints();
  }

  final GetPointUseCase _getPointUseCase;

  Future<void> getPoints() async {
    state = state.copyWith(isLoading: true);
    final value = await _getPointUseCase.call(null);
    state = value.fold((l) {
      return state.copyWith(isLoading: false);
    }, (r) {
      final Set<Marker> markers = {};
      for (LocationPoint point in r) {
        markers.add(
          Marker(
            markerId: MarkerId('${point.latitude}'),
            position: LatLng(point.latitude, point.longitude),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          ),
        );
      }
      return state.copyWith(isLoading: false, markers: markers);
    });
  }
}

final getPointsProvider =
    StateNotifierProvider<GetPointsNotifier, MapDataState>((ref) {
  final useCase = ref.read(getPointsUseCaseProvider);
  return GetPointsNotifier(useCase);
});
