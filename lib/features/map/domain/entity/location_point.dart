import 'package:hive/hive.dart';

part 'location_point.g.dart';

@HiveType(typeId: 1)
class LocationPoint {
  LocationPoint({required this.latitude, required this.longitude});

  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;
}
