import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/features/map/domain/usecases/calculate_utm.dart';

class CalculateUtmNotifier extends StateNotifier<CalculateUtmUseState> {
  CalculateUtmNotifier(this._useCase) : super(CalculateUtmUseState.initial());
  final CalculateUtmUseCase _useCase;

  Future<void> calculateUtm(
      double northing, double easting, int zone, String band) async {
    state = state.copyWith(isLoading: true);
    final value =
        await _useCase.call(CalculateUtmParams(northing, easting, zone, band));
    state = value.fold((l) {
      return state = state.copyWith(isLoading: false);
    }, (r) {
      return state = state.copyWith(latLng: r, isLoading: false);
    });
  }
}

class CalculateUtmUseState {
  final LatLng latLng;
  final bool isLoading;

  CalculateUtmUseState(this.latLng, this.isLoading);

  CalculateUtmUseState.initial({
    this.latLng = const LatLng(0.0, 0.0),
    this.isLoading = false,
  });

  CalculateUtmUseState copyWith({LatLng? latLng, bool? isLoading}) {
    return CalculateUtmUseState(
      latLng ?? this.latLng,
      isLoading ?? this.isLoading,
    );
  }
}

final calculateUtmNotifierProvider =
StateNotifierProvider<CalculateUtmNotifier, CalculateUtmUseState>((ref) {
  final useCase = ref.watch(calculateUtmProvider);
  return CalculateUtmNotifier(useCase);
});
