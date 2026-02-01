import 'package:cloud_firestore/cloud_firestore.dart';

class IncidentReport {
  final String incidentType;
  final String description;
  final String? reporterId;
  final String? severity;
  final double latitude;
  final double longitude;
  final String? address;
  final String? imageUrl;
  final DateTime? createdAt;

  IncidentReport({
    required this.incidentType,
    required this.description,
    required this.reporterId,
    required this.severity,
    required this.latitude,
    required this.longitude,
    this.address,
    this.imageUrl,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "incidentType": incidentType,
      "description": description,
      "reporterId": reporterId,
      "severity": severity,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "imageUrl": imageUrl,
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  factory IncidentReport.fromMap(Map<String, dynamic> map) {
    return IncidentReport(
      incidentType: map['incidentType'] ?? '',
      description: map['description'] ?? '',
      reporterId: map['reporterId'] ?? '',
      severity: map['severity'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      address: map['address'],
      imageUrl: map['imageUrl'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
