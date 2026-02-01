// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:incident_response_app/widget/incident_card.dart';
import 'package:geolocator/geolocator.dart';

class NearbyIncidentScreen extends StatefulWidget {
  const NearbyIncidentScreen({super.key});

  @override
  State<NearbyIncidentScreen> createState() => _NearbyIncidentScreenState();
}

class _NearbyIncidentScreenState extends State<NearbyIncidentScreen> {
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nearby Incidents",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("incident_report")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No incidents reported nearby."));
          }
          final incidents = snapshot.data!.docs;
          if (currentPosition == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: incidents.length,
            itemBuilder: (context, index) {
              final incidentData =
                  incidents[index].data() as Map<String, dynamic>;
              return IncidentCard(
                incidentData: incidentData,
                userPosition: currentPosition,
              );
            },
          );
        },
      ),
    );
  }
}
