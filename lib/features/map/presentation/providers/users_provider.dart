import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/domain/entity/user.dart';
import 'package:land_survey/features/map/domain/usecases/fetch_users_usecase.dart';

class FetchUsersNotifier extends StateNotifier<List<LandUser>> {
  FetchUsersNotifier(this._useCase) : super([]){fetchUsers();}

  final FetchUsersUseCase _useCase;

  Future<void> fetchUsers() async {
    final value = await _useCase.call(null);
    state = value.fold((l) {
      return state = [];
    }, (r) {
      return state = r;
    });
  }
}

final fetchUsersNotifier = StateNotifierProvider.autoDispose<FetchUsersNotifier, List<LandUser>>((ref){
  final useCase = ref.read( fetchUsersCaseProvider);
  return FetchUsersNotifier(useCase);
});
