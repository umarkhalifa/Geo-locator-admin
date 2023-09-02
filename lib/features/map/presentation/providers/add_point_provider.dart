import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/domain/usecases/add_point_usecase.dart';
import 'package:land_survey/features/map/presentation/providers/get_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/map_data_state.dart';

class AddPointsNotifier extends StateNotifier<MapDataState> {
  AddPointsNotifier(this._addPointUseCase, this._ref) : super(MapDataState.initial());

  final AddPointUseCase _addPointUseCase;
  final Ref _ref;

  Future<void> addPoint(LocationPoint locationPoint)async{
    final value = await _addPointUseCase.call(locationPoint);
    state = value.fold((l) {
      return state.copyWith(isLoading: false);
    }, (r) {
      return state.copyWith(isLoading: false,);

    }
    );
    await _ref.read(getPointsProvider.notifier).getPoints();
  }
}

final addPointsProvider = StateNotifierProvider<AddPointsNotifier, MapDataState>((ref) {
  final useCase = ref.read(addPointUseCaseProvider);
  return AddPointsNotifier(useCase,ref);
});