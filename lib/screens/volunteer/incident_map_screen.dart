// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class IncidentMapScreen extends StatefulWidget {
  final Position userPosition;
  final double incidentLatitude;
  final double incidentLongitude;

  const IncidentMapScreen({
    super.key,
    required this.userPosition,
    required this.incidentLatitude,
    required this.incidentLongitude,
  });

  @override
  State<IncidentMapScreen> createState() => _IncidentMapScreenState();
}

class _IncidentMapScreenState extends State<IncidentMapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setMarkersAndPolylines();
  }

  void _setMarkersAndPolylines() {
    _markers.add(
      Marker(
        markerId: const MarkerId('user'),
        position: LatLng(
          widget.userPosition.latitude,
          widget.userPosition.longitude,
        ),
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('incident'),
        position: LatLng(widget.incidentLatitude, widget.incidentLongitude),
        infoWindow: const InfoWindow(title: 'Incident Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: [
          LatLng(widget.userPosition.latitude, widget.userPosition.longitude),
          LatLng(widget.incidentLatitude, widget.incidentLongitude),
        ],
        color: Colors.red,
        width: 5,
      ),
    );
  }

  void _fitBounds() {
    final lat1 = widget.userPosition.latitude;
    final lng1 = widget.userPosition.longitude;
    final lat2 = widget.incidentLatitude;
    final lng2 = widget.incidentLongitude;

    if (lat1 == lat2 && lng1 == lng2) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat1, lng1), zoom: 15),
        ),
      );
    }
    LatLng southwest = LatLng(
      lat1 < lat2 ? lat1 : lat2,
      lng1 < lng2 ? lng1 : lng2,
    );

    LatLng northeast = LatLng(
      lat1 > lat2 ? lat1 : lat2,
      lng1 > lng2 ? lng1 : lng2,
    );

    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(southwest: southwest, northeast: northeast),
        100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Incident Location',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD32F2F),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.userPosition.latitude,
            widget.userPosition.longitude,
          ),
          zoom: 12,
        ),
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (controller) {
          Future.delayed(const Duration(milliseconds: 300), () {
            _fitBounds();
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Fit Bounds"),
        icon: const Icon(Icons.directions),
        onPressed: () {
          _fitBounds();
        },
      ),
    );
  }
}
