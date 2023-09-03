import 'package:dartz/dartz.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';

abstract class MapFirestoreRepository{
  Future<Either<Failure,bool>> deletePoint(int index);
  Future<Either<Failure,bool>> addPoint(double latitude, double longitude);
  Stream<Either<Failure,List<LocationPoint>>> watchPoint();
}