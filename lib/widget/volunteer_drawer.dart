import 'package:flutter/material.dart';
import 'package:incident_response_app/screens/volunteer/add_volunteerPage.dart';
import 'package:incident_response_app/screens/volunteer/volunteer_data_page.dart';
import 'package:incident_response_app/screens/volunteer/volunteer_login_screen.dart';
import '../../screens/volunteer/nearby_incident_details.dart';
import 'custom_listTile.dart';

class VolunteerDrawer extends StatelessWidget {
  const VolunteerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,

        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFD32F2F)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.volunteer_activism,
                      color: Color(0xFFD32F2F),
                      size: 35,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Volunteer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Ready to help 🚑",
                  style: TextStyle(color: Colors.white70),
                ),
                // Align(
                //   alignment: Alignment.bottomLeft,
                //   child: Text(
                //     "Volunteer Menu",
                //     style: TextStyle(color: Colors.white, fontSize: 18),
                //   ),
                // ),
              ],
            ),
          ),
          CustomListTile(
            icon: Icons.home,
            title: "Home",
            onTap: () {
              Navigator.pop(context);
            },
          ),
          CustomListTile(
            icon: Icons.warning,
            title: "Nearby Incidents",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NearbyIncidentDetailsScreen(),
                ),
              );
            },
          ),
          CustomListTile(icon: Icons.settings, title: "Settings", onTap: () {}),
          CustomListTile(
            icon: Icons.add,
            title: "Add Volunteer",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddVolunteerPage()),
              );
            },
          ),
           CustomListTile(
            icon: Icons.data_array,
            title: "Show Volunteer",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VolunteerDataPage(),
                ),
              );
            },
          ),
          CustomListTile(
            icon: Icons.logout,
            title: "Logout",
            iconColor: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VolunteerLoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
