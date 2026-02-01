import 'package:cloud_firestore/cloud_firestore.dart';

class IncidentReportService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> submitIncidentReport(
    Map<String, dynamic> incidentData,
  ) async {
    await _firestore.collection("incident_report").add(incidentData);
  }
}
