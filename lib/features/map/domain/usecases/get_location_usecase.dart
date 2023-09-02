import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/map/domain/repository/map_repository.dart';
import 'package:location/location.dart';

class GetLocationUseCase implements UseCase<LocationData, void> {
  final MapRepository _mapRepository;

  GetLocationUseCase(this._mapRepository);

  @override
  Future<Either<Failure, LocationData>> call(void params) async {
    return await _mapRepository.getUsersLocation();
  }
}

final getLocationProvider = Provider((ref) {
  final repository = ref.watch(mapRepositoryProvider);
  return GetLocationUseCase(repository);
});
