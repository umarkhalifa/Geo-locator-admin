import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';

import 'core/router/router.dart';
import 'features/map/data/data_soucre/map_local_data_source.dart';
import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LocationPointAdapter());
  boxLocation = await Hive.openBox<LocationPoint>('locations');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routeProvider);
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: "Faktum",
      ),
      routerConfig: router,
    );
  }
}
