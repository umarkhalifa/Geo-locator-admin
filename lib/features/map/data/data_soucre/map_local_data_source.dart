import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entity/location_point.dart';

late Box boxLocation;

class MapLocalDataSource {
  Future<List<LocationPoint>> getLocationPoint() async {
    try {
      return [
        for (var element in boxLocation.values.toList())
          LocationPoint(
              latitude: element.latitude, longitude: element.longitude)
      ];
    } catch (e) {
      throw Exception('Error getting map points');
    }
  }

  Future<bool> addLocationPoint({required LocationPoint locationPoint}) async {
    try {
      boxLocation.add(locationPoint);
      return true;
    } catch (e) {
      throw Exception('Error getting adding point');
    }
  }

  Future<bool> deleteLocationPoint({required int index}) async {
    try {
      boxLocation.deleteAt(index);
      return true;
    } catch (e) {
      throw Exception('Error deleting point');
    }
  }
}

final mapLocalProvider = Provider((ref) => MapLocalDataSource());