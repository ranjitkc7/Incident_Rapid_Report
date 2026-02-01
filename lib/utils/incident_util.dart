import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

String calculateDistance(
  Position? userPosition,
  Map<String, dynamic> incidentData,
) {
  if (userPosition == null ||
      incidentData["latitude"] == null ||
      incidentData["longitude"] == null) {
    return "Unknown distance";
  }
  final distanceInMeters = Geolocator.distanceBetween(
    userPosition.latitude,
    userPosition.longitude,
    incidentData["latitude"],
    incidentData["longitude"],
  );

  if (distanceInMeters < 1000) {
    return "${distanceInMeters.toStringAsFixed(0)} m away";
  } else {
    return "${(distanceInMeters / 1000).toStringAsFixed(2)} km away";
  }
}

String timeAgoFormat(Timestamp timestamp) {
  final DateTime incidentTime = timestamp.toDate();
  final Duration difference = DateTime.now().difference(incidentTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else {
    return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
  }
}
