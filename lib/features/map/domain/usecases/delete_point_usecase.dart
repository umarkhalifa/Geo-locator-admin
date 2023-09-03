import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/failure.dart';
import 'package:land_survey/core/use_case.dart';
import 'package:land_survey/features/map/domain/repository/map_repository.dart';

class DeletePointUseCase extends UseCase<bool, int> {
  final MapRepository _mapRepository;

  DeletePointUseCase(this._mapRepository);

  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await _mapRepository.deleteMapPoint(params);
  }
}

final deletePointUseCaseProvider = Provider((ref) {
  final repo = ref.read(mapRepositoryProvider);
  return DeletePointUseCase(repo);
});
