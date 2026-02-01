import 'package:flutter/material.dart';
import '/widget/emergency_card.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contact', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFD32F2F),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        child: Column(
          children: [
            EmergencyContactCard(
              icon: Icons.local_police,
              title: "Police",
              number: "100",
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            EmergencyContactCard(
              icon: Icons.local_fire_department,
              title: "Fire",
              number: "101",
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            EmergencyContactCard(
              icon: Icons.local_hospital,
              title: "Ambulance",
              number: "102",
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
