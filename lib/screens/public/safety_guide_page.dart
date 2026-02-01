import 'package:flutter/material.dart';
import '../../widget/safety_tile.dart';

class SafetyGuidePage extends StatefulWidget {
  const SafetyGuidePage({super.key});

  @override
  State<SafetyGuidePage> createState() => _SafetyGuidePageState();
}

class _SafetyGuidePageState extends State<SafetyGuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safety Guidelines", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFD32F2F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SafetyTile(
                icon: Icons.local_fire_department,
                title: "Fire Emergency",
                steps: const [
                  "Stay calm and alert others.",
                  "Evacuate the area immediately.",
                  "Call emergency services.",
                  "Use a fire extinguisher if trained.",
                ],
              ),
              SafetyTile(
                icon: Icons.public,
                title: "Earthquake Safety",
                steps: const [
                  "Drop, Cover, and Hold On.",
                  "Stay indoors until the shaking stops.",
                  "Avoid windows and heavy objects.",
                  "If outside, move to an open area away from buildings.",
                ],
              ),
              SafetyTile(
                icon: Icons.water,
                title: "Flood Emergency",
                steps: const [
                  "Move to higher ground",
                  "Avoid walking in flowing water",
                  "Turn off electricity",
                ],
              ),
              SafetyTile(
                icon: Icons.health_and_safety,
                title: "Medical Emergency",
                steps: const [
                  "Call emergency services immediately.",
                  "Provide first aid if trained.",
                  "Keep the person comfortable and monitor their condition.",
                  "Check breathing",
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
