import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/authentication/presentation/screens/splash_screen.dart';

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
    );
  }
}


