import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/map/domain/repository/map_repository.dart';

class CalculateUtmUseCase extends UseCase<LatLng, CalculateUtmParams> {
  final MapRepository _mapRepository;

  CalculateUtmUseCase(this._mapRepository);

  @override
  Future<Either<Failure, LatLng>> call(CalculateUtmParams params) async {
    final value = await _mapRepository.calculateUtm(
        params.northing, params.easting, params.zone, params.band);
    return value;
  }
}

class CalculateUtmParams {
  final double northing;
  final double easting;
  final int zone;
  final String band;

  CalculateUtmParams(this.northing, this.easting, this.zone, this.band);
}

final calculateUtmProvider = Provider((ref) {
  final repository = ref.read(mapRepositoryProvider);
  return CalculateUtmUseCase(repository);
});

