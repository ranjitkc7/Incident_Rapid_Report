import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChange;

  const DropdownField({super.key, required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: const Text("Select field"),
          isExpanded: true,
          onChanged: onChange,
          items: const [
            DropdownMenuItem(
              value: "Fire",
              child: Row(
                children: [
                  Icon(Icons.local_fire_department, color: Colors.red),
                  SizedBox(width: 10),
                  Text("Fire"),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "Accident",
              child: Row(
                children: [
                  Icon(Icons.car_crash, color: Colors.orange),
                  SizedBox(width: 10),
                  Text("Accident"),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "Medical",
              child: Row(
                children: [
                  Icon(Icons.local_hospital, color: Colors.green),
                  SizedBox(width: 10),
                  Text("Medical Emergency"),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "Crime",
              child: Row(
                children: [
                  Icon(Icons.report, color: Colors.deepPurple),
                  SizedBox(width: 10),
                  Text("Crime"),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "Pollution",
              child: Row(
                children: [
                  Icon(Icons.factory, color: Colors.blueGrey),
                  SizedBox(width: 10),
                  Text("Pollution"),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "Other",
              child: Row(
                children: [
                  Icon(Icons.help_outline, color: Colors.grey),
                  SizedBox(width: 10),
                  Text("Other"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
