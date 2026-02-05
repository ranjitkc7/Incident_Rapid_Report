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


