import 'package:hive/hive.dart';

part 'location_point.g.dart';

@HiveType(typeId: 1)
class LocationPoint {
  LocationPoint(
      {required this.latitude,
      required this.longitude,
      required this.northing,
      required this.easting,
      required this.zone,
      required this.band,
      required this.name,
      required this.height});

  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  double northing;

  @HiveField(3)
  double easting;

  @HiveField(4)
  int zone;

  @HiveField(5)
  String band;

  @HiveField(6)
  String name;

  @HiveField(7)
  double height;
}
