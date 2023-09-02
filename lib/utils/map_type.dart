import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MyMapType { normal, satellite, terrain, hybrid }

extension ToMap on MyMapType {
  MapType toType() {
    switch (this) {
      case MyMapType.normal:
        return MapType.normal;
      case MyMapType.satellite:
        return MapType.satellite;
      case MyMapType.terrain:
        return MapType.terrain;
      default:
        return MapType.hybrid;
    }
  }
}

extension ToText on MyMapType {
  String toText() {
    switch (this) {
      case MyMapType.normal:
        return "Normal";
      case MyMapType.satellite:
        return "Satellite";
      case MyMapType.terrain:
        return "Terrain";
      default:
        return "Hybrid";
    }
  }
}