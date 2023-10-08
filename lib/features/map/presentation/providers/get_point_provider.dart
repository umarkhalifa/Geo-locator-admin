import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/domain/usecases/get_firestore_points.dart';
import 'package:land_survey/features/map/presentation/providers/map_data_state.dart';

import '../widgets/land_map.dart';
import 'map_state_provider.dart';

class GetPointsNotifier extends StateNotifier<MapDataState> {
  GetPointsNotifier(
    this._getPointUseCase,
    this.ref,
  ) : super(MapDataState.initial()) {
    getPoints();
  }

  final GetFirestorePointUseCase _getPointUseCase;
  final Ref ref;

  Future<void> getPoints() async {
    state = state.copyWith(isLoading: true);
    final value = _getPointUseCase.call(null);
    await for (var element in value) {
      state = element.fold((l) {
        return state = state.copyWith(isLoading: false);
      }, (r) {
        final Set<Marker> markers = {};
        for (LocationPoint point in r) {
          markers.add(
            Marker(
                markerId: MarkerId('${point.latitude}'),
                position: LatLng(point.latitude, point.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueCyan),
                onTap: () {
                  if (ref.read(mapNotifierProvider).showCompass) {
                    ref.read(markerIndex.notifier).state = r.indexOf(point);
                  } else {
                    ref.read(mapNotifierProvider.notifier).updateCompass(true);
                    ref.read(markerIndex.notifier).state = r.indexOf(point);
                  }
                }),
          );
        }
        return state =
            state.copyWith(markers: markers, points: r, searchPoints: r);
      });
    }
  }

  void searchPoints(String name) {
    if (name == '') {
      state = state.copyWith(searchPoints: state.points);
    } else {
      final points = state.points!.where((element) {
        return element.name.contains(name);
      }).toList();
      state = state.copyWith(searchPoints: points);
    }
  }

  void resetSearch() {
    state = state.copyWith(searchPoints: state.points);
  }
}

final getPointsProvider =
    StateNotifierProvider<GetPointsNotifier, MapDataState>((ref) {
  final useCase = ref.read(getFirestorePointsUseCaseProvider);
  return GetPointsNotifier(useCase, ref);
});
