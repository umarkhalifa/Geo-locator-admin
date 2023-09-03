import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/domain/usecases/get_firestore_points.dart';
import 'package:land_survey/features/map/domain/usecases/get_points_usecase.dart';
import 'package:land_survey/features/map/presentation/providers/map_data_state.dart';
import 'package:land_survey/utils/in_memory_state.dart';

class GetPointsNotifier extends StateNotifier<MapDataState> {
  GetPointsNotifier(this._getPointUseCase, this._ref)
      : super(MapDataState.initial()) {
    getPoints();
  }

  final Ref _ref;
  final GetFirestorePointUseCase _getPointUseCase;

  final _pointState = InMemoryStore<List<LocationPoint>>([]);

  Stream<List<LocationPoint>> _locationPoints()=> _pointState.stream;
  List<LocationPoint> get points => _pointState.value;
  Future<void> getPoints() async {
    state = state.copyWith(isLoading: true);
    final value = _getPointUseCase.call(null);
    await for(var element in value){
      state  = element.fold((l) {

        return state = state.copyWith(isLoading: false);
      }, (r) {
        final Set<Marker> markers = {};
            for (LocationPoint point in r) {
              markers.add(
                Marker(
                  markerId: MarkerId('${point.latitude}'),
                  position: LatLng(point.latitude, point.longitude),
                  icon:
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
                ),
              );
            }
        return state = state.copyWith(markers: markers);
      });
    }
    // print(points);
    // final Set<Marker> markers = {};
    //     for (LocationPoint point in points) {
    //       markers.add(
    //         Marker(
    //           markerId: MarkerId('${point.latitude}'),
    //           position: LatLng(point.latitude, point.longitude),
    //           icon:
    //           BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    //         ),
    //       );
    //     }
    //     state = state.copyWith(markers: markers,isLoading: false);
    // value.listen((event) {
    //   event.fold((l){
    //     state = state.copyWith(isLoading: false);
    //     return state;
    //   } , (r) {
    //     final Set<Marker> markers = {};
    //     for (LocationPoint point in r) {
    //       markers.add(
    //         Marker(
    //           markerId: MarkerId('${point.latitude}'),
    //           position: LatLng(point.latitude, point.longitude),
    //           icon:
    //           BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    //         ),
    //       );
    //     }
    //     state.copyWith(isLoading: false, markers: markers);
    //     return state;
    //   });
    // });
  }
}

final getPointsProvider =
    StateNotifierProvider<GetPointsNotifier, MapDataState>((ref) {
  final useCase = ref.read(getFirestorePointsUseCaseProvider);
  return GetPointsNotifier(useCase, ref);
});
