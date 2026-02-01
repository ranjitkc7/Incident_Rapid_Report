import 'package:flutter/material.dart';
import 'suggestion_page.dart';
import 'emergency_contact_screen.dart';
import 'report_incident_screen.dart';
import '/widget/build_card.dart';
import 'safety_guide_page.dart';
import 'nearby_incident_screen.dart';

class PublicHomeScreen extends StatefulWidget {
  const PublicHomeScreen({super.key});

  @override
  State<PublicHomeScreen> createState() => _PublicHomeScreenState();
}

class _PublicHomeScreenState extends State<PublicHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Public Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome 👋",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Report incidents and stay safe",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            BuildCard(
              title: "Report Incident",
              subtitle: "Report fire, accident, or emergency",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportIncidentScreen(),
                  ),
                );
              },
              icon: Icons.report,
            ),
            BuildCard(
              title: "Nearby Incidents",
              subtitle: "View incidents around you",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NearbyIncidentScreen(),
                  ),
                );
              },
              icon: Icons.location_on,
            ),
            BuildCard(
              title: "Emergency Contacts",
              subtitle: "Police, Fire, Ambulance",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmergencyContactScreen(),
                  ),
                );
              },
              icon: Icons.phone,
            ),
            BuildCard(
              title: "Safety Guidelines",
              subtitle: "What to do in emergencies",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SafetyGuidePage(),
                  ),
                );
              },
              icon: Icons.info_outlined,
            ),
            BuildCard(
              title: "Add Suggestion",
              subtitle: "Enter your own suggestion",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SuggestionPage(),
                  ),
                );
              },
              icon: Icons.note_add_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
