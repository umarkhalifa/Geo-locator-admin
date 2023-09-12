import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:land_survey/features/map/data/model/user_model.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';

class MapFirestoreData {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  MapFirestoreData(this._firestore, this._firebaseAuth);

  Future<bool> addPoint(double latitude, double longitude, double northing,
      double easting, int zone, String band, String name, double height) async {
    try {
      await _firestore.collection("POINTS").add({
        'latitude': latitude,
        'longitude': longitude,
        'northing': northing,
        'easting': easting,
        'zone': zone,
        'band': band,
        'name': name,
        'height': height
      });
      return true;
    } catch (e) {
      throw (Exception("Point could not be added"));
    }
  }

  Stream<List<LocationPoint>> watchPoint() async* {
    yield* _firestore.collection('POINTS').snapshots().map((querySnapshot) {
      List<LocationPoint> locationPoints = [];
      for (var document in querySnapshot.docs) {
        double latitude = document.data()['latitude'] ?? 0.0;
        double longitude = document.data()['longitude'] ?? 0.0;
        double northing = document.data()['northing'] ?? 0.0;
        double easting = document.data()['easting'] ?? 0.0;
        int zone = document.data()['zone'] ?? 0;
        String band = document.data()['band'] ?? '';
        String name = document.data()['name'] ?? '';
        double height = document.data()['height'];
        locationPoints.add(LocationPoint(
            latitude: latitude,
            longitude: longitude,
            northing: northing,
            easting: easting,
            zone: zone,
            band: band,
            name: name,
            height: height));
      }
      return locationPoints;
    });
  }

  Future<bool> deletePoint(int index) async {
    try {
      final data = await _firestore.collection("POINTS").get();
      final id = data.docs.elementAt(index).id;
      _firestore.collection("POINTS").doc(id).delete();
      return true;
    } catch (e) {
      throw (Exception('Error deleting point'));
    }
  }

  Future<List<LandUserModel>> fetchUsers() async {
    try {
      final data = await _firestore
          .collection("USERS")
          .where('email', isNotEqualTo: _firebaseAuth.currentUser?.email)
          .get();
      return data.docs
          .map((e) => LandUserModel.fromFirebase(e.data()))
          .toList();
    } catch (e) {
      throw (Exception("Error fetching user"));
    }
  }
}

final firestoreDataProvider = Provider((ref) {
  return MapFirestoreData(FirebaseFirestore.instance, FirebaseAuth.instance);
});
