import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerModel {
  final String volunteerName;
  final String volunteerNumber;
  final String volunteerField;
  final Timestamp? createdAt;

  VolunteerModel({
    required this.volunteerName,
    required this.volunteerNumber,
    required this.volunteerField,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "volunteer_name": volunteerName,
      "volunteer_number": volunteerNumber,
      "volunteer_field": volunteerField,
      "createdAt": FieldValue.serverTimestamp(),
    };
  }

  factory VolunteerModel.fromMap(Map<String, dynamic> map) {
    return VolunteerModel(
      volunteerName: map["volunteer_name"] ?? "",
      volunteerNumber: map["volunteer_number"] ?? "",
      volunteerField: map["volunteer_field"] ?? "",
      createdAt: map["createdAt"],
    );
  }
}
