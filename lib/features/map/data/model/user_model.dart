import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:land_survey/features/map/domain/entity/user.dart';

class LandUserModel extends LandUser {
  LandUserModel(super.email, super.password);

  factory LandUserModel.fromFirebase(Map<String,dynamic> snapshot) {
    return LandUserModel(snapshot['email'], snapshot['id']);
  }
}
