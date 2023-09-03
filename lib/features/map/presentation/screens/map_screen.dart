import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/authentication/presentation/screens/splash_screen.dart';
import 'package:land_survey/features/map/data/data_soucre/firestore_data_source.dart';
import 'package:land_survey/features/map/domain/usecases/get_firestore_points.dart';
import 'package:land_survey/features/map/presentation/providers/get_point_provider.dart';

import '../providers/map_state_provider.dart';
import '../widgets/land_map.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapNotifierProvider);
    return Scaffold(
      body: mapState.isLoading == true
          ? const SplashScreen()
          : LandMap(mapState: mapState),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        final value =  ref.read(getPointsProvider);
        print(value.markers);
      }),
    );
  }
}


