// ignore_for_file: deprecated_member_use
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission denied forever");
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static Future<String> getAddress(Position position) async {
    final placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final place = placemark.first;

    return "${place.street}, ${place.locality}, ${place.administrativeArea}";
  }
}
