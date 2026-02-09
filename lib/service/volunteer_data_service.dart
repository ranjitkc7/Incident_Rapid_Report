// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/volunteer_model.dart';

class VolunteerDataService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addVolunteer(VolunteerModel volunteer) async {
    await _firestore.collection("volunteers").add({...volunteer.toMap()});
  }
}
