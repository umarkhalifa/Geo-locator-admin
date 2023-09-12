import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/features/map/domain/usecases/calculate_utm.dart';

class CalculateUtmNotifier extends StateNotifier<CalculateUtmUseState> {
  CalculateUtmNotifier(this._useCase) : super(CalculateUtmUseState.initial());
  final CalculateUtmUseCase _useCase;

  Future<void> calculateUtm(double northing, double easting, int zone,
      String band, double height) async {
    state = state.copyWith(
        isLoading: true,
        northing: northing,
        easting: easting,
        zone: zone,
        band: band,
        height: height);
    final value =
        await _useCase.call(CalculateUtmParams(northing, easting, zone, band));
    state = value.fold((l) {
      return state = state.copyWith(isLoading: false);
    }, (r) {
      return state =
          state.copyWith(latLng: r, isLoading: false, showButton: true);
    });
  }

  void disAbleButton() {
    state = state.copyWith(showButton: false);
  }
}

class CalculateUtmUseState {
  final LatLng latLng;
  final bool isLoading;
  final bool? showButton;
  final double? northing;
  final double? easting;
  final int? zone;
  final String? band;
  final double? height;

  CalculateUtmUseState(this.latLng, this.isLoading, this.showButton,
      this.northing, this.easting, this.zone, this.band, this.height);

  CalculateUtmUseState.initial(
      {this.latLng = const LatLng(0.0, 0.0),
      this.isLoading = false,
      this.showButton = false,
      this.northing = 0.0,
      this.easting = 0.0,
      this.zone = 0,
      this.band = '',
      this.height = 0});

  CalculateUtmUseState copyWith({
    LatLng? latLng,
    bool? isLoading,
    bool? showButton,
    double? northing,
    double? easting,
    int? zone,
    String? band,
    double? height,
  }) {
    return CalculateUtmUseState(
        latLng ?? this.latLng,
        isLoading ?? this.isLoading,
        showButton ?? this.showButton,
        northing ?? this.northing,
        easting ?? this.easting,
        zone ?? this.zone,
        band ?? this.band,
        height ?? this.height);
  }
}

final calculateUtmNotifierProvider =
    StateNotifierProvider<CalculateUtmNotifier, CalculateUtmUseState>((ref) {
  final useCase = ref.watch(calculateUtmProvider);
  return CalculateUtmNotifier(useCase);
});
