import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';

class MapFirestoreData {
  final FirebaseFirestore _firestore;

  MapFirestoreData(this._firestore);

  Future<bool> addPoint(double latitude, double longitude) async {
    try {
      await _firestore
          .collection("POINTS")
          .add({'latitude': latitude, 'longitude': longitude});
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
        locationPoints
            .add(LocationPoint(latitude: latitude, longitude: longitude));
      }
      return locationPoints;
    });
  }

  Future<bool> deletePoint(int index)async{
    try{
      final data =  await _firestore.collection("POINTS").get();
      final id = data.docs.elementAt(index).id;
      _firestore.collection("POINTS").doc(id).delete();
      return true;
    }catch (e){
      throw(Exception('Error deleting point'));
    }
  }
}

final firestoreDataProvider = Provider((ref) {
  return MapFirestoreData(FirebaseFirestore.instance);
});

