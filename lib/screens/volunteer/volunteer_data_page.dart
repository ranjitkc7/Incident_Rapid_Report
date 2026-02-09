import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/volunteer_model.dart';
import '../../widget/listTile_for_volunteer.dart';

class VolunteerDataPage extends StatefulWidget {
  const VolunteerDataPage({super.key});

  @override
  State<VolunteerDataPage> createState() => _VolunteerDataPageState();
}

class _VolunteerDataPageState extends State<VolunteerDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteer Data", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("volunteers")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No volunteers found"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final volunteer = VolunteerModel.fromMap(
                doc.data() as Map<String, dynamic>,
              );

              return CustomVListTile(
                icon: _getIcon(volunteer.volunteerField),
                subtitle: volunteer.volunteerNumber,
                title: volunteer.volunteerName,
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }

  IconData _getIcon(String field) {
    switch (field) {
      case "Fire":
        return Icons.local_fire_department;
      case "Medical":
        return Icons.local_hospital;
      case "Accident":
        return Icons.car_crash;
      case "Crime":
        return Icons.report;
      case "Pollution":
        return Icons.factory;
      default:
        return Icons.person;
    }
  }
}
