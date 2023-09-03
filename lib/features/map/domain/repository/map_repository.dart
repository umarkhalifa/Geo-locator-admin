import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/features/map/data/data_soucre/map_local_data_source.dart';
import 'package:land_survey/features/map/data/data_soucre/map_remote_data_source.dart';
import 'package:land_survey/features/map/data/repository/map_repo_impl.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:location/location.dart';

abstract class MapRepository {
  Future<Either<Failure, LocationData>> getUsersLocation();

  Future<Either<Failure, LatLng>> calculateUtm(
      double northing, double easting, int zone, String band);

  Future<Either<Failure, List<LocationPoint>>> getMapPoints();

  Future<Either<Failure, bool>> addMapPoint(LocationPoint locationPoint);

  Future<Either<Failure, bool>> deleteMapPoint(int index);
}

final mapRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(mapDataSourceProvider);
  final localSource = ref.read(mapLocalProvider);
  return MapRepositoryImpl(dataSource, localSource);
});
