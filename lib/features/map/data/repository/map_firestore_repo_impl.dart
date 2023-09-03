import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/features/map/data/data_soucre/firestore_data_source.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/domain/entity/user.dart';
import 'package:land_survey/features/map/domain/repository/map_firestore_repo.dart';

class MapFirestoreRepoImpl implements MapFirestoreRepository {
  final MapFirestoreData _firestoreData;

  MapFirestoreRepoImpl(this._firestoreData);

  @override
  Future<Either<Failure, bool>> addPoint(
      double latitude, double longitude) async {
    try {
      return Right(await _firestoreData.addPoint(latitude, longitude));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePoint(int index) async {
    try {
      return Right(await _firestoreData.deletePoint(index));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<LocationPoint>>> watchPoint() async* {
    try {
      final value = _firestoreData.watchPoint();
      await for (var element in value) {
        yield Right(element);
      }
    } catch (e) {
      yield Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LandUser>>> fetchUsers()async{
    try{
      return Right(await _firestoreData.fetchUsers());
    }catch (e){
      return Left(Failure(e.toString()));
    }
  }
}

final mapFirestoreRepoProvider = Provider((ref) {
  final source = ref.read(firestoreDataProvider);
  return MapFirestoreRepoImpl(source);
});
