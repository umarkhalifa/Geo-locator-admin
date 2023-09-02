import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/features/map/data/data_soucre/map_local_data_source.dart';
import 'package:land_survey/features/map/data/data_soucre/map_remote_data_source.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:location/location.dart';

import '../../domain/repository/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource _mapRemoteDataSource;
  final MapLocalDataSource _mapLocalDataSource;

  MapRepositoryImpl(this._mapRemoteDataSource, this._mapLocalDataSource);

  @override
  Future<Either<Failure, LocationData>> getUsersLocation() async {
    try {
      return Right(await _mapRemoteDataSource.getUsersLocation());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LatLng>> calculateUtm(double northing, double easting, int zone, String band)async {
    try{
      final value =  await _mapRemoteDataSource.calculateUtm(northing, easting, zone, band);
      return Right(value);
    }catch(e){
      return const Left(Failure("Error calculating coordinates"));
    }
  }

  @override
  Future<Either<Failure, bool>> addMapPoint(LocationPoint locationPoint)async{
    try{
      final value =  await _mapLocalDataSource.addLocationPoint(locationPoint: locationPoint);
      return Right(value);
    }catch(e){
      return const Left(Failure("Error adding point"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMapPoint(int index) async{
    try{
      final value =  await _mapLocalDataSource.deleteLocationPoint(index: index);
      return Right(value);
    }catch(e){
      return const Left(Failure("Error deleting point"));
    }
  }

  @override
  Future<Either<Failure, List<LocationPoint>>> getMapPoints()async{
    try{
      final value =  await _mapLocalDataSource.getLocationPoint();
      return Right(value);
    }catch(e){
      return const Left(Failure("Error fetching points"));
    }
  }
}
