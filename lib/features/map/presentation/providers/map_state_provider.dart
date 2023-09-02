import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/domain/usecases/get_location_usecase.dart';
import 'package:land_survey/features/map/presentation/providers/map_data_state.dart';
import 'package:land_survey/utils/map_type.dart';

class MapScreenNotifier extends StateNotifier<MapDataState> {
  MapScreenNotifier(this._getLocationUseCase) : super(MapDataState.initial()) {
    getCurrentLocation();
  }

  final GetLocationUseCase _getLocationUseCase;

  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true);
    final value = await _getLocationUseCase.call(null);
    state = value.fold((l) {
      return state.copyWith(isLoading: false);
    }, (r) {
      return state.copyWith(
          latitude: r.latitude, longitude: r.longitude, isLoading: false);
    });
  }

  void updateMapType(MyMapType mapType) {
    state = state.copyWith(mapType: mapType);
  }

  void updateCompass(){
    state = state.copyWith(showCompass: !state.showCompass);
  }
}

final mapNotifierProvider =
    StateNotifierProvider<MapScreenNotifier, MapDataState>((ref) {
  final useCase = ref.watch(getLocationProvider);
  return MapScreenNotifier(useCase);
});
