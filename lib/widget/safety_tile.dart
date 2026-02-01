import 'package:flutter/material.dart';

class SafetyTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> steps;

  const SafetyTile({
    super.key,
    required this.icon,
    required this.title,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(icon, color: Color(0xFFD32F2F), size: 33),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: const Text(
          "Tap to view safety steps",
          style: TextStyle(fontSize: 12),
        ),
        children: steps
            .map(
              (step) => ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 20,
                  color: Colors.green,
                ),
                title: Text(step),
              ),
            )
            .toList(),
      ),
    );
  }
}
