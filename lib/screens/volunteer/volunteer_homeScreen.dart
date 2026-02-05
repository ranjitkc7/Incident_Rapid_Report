import 'package:flutter/material.dart';
import 'package:incident_response_app/widget/custom_button.dart';
import 'package:incident_response_app/widget/volunteer_drawer.dart';
import 'nearby_incident_details.dart';

class VolunteerHomeScreen extends StatefulWidget {
  const VolunteerHomeScreen({super.key});

  @override
  State<VolunteerHomeScreen> createState() => _VolunteerHomeScreenState();
}

class _VolunteerHomeScreenState extends State<VolunteerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const VolunteerDrawer(),

      appBar: AppBar(
        title: const Text(
          'Volunteer Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD32F2F),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Welcome! to the Volunteer 👏",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Rapid Response",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NearbyIncidentDetailsScreen(),
                  ),
                );
              },
              color: Colors.white,
              radius: 10,
              width: double.infinity,
              bgColor: const Color(0xFFD32F2F),
            ),
          ],
        ),
      ),
    );
  }
}
