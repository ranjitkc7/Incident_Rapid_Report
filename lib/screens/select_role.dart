import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectRole extends StatefulWidget {
  const SelectRole({super.key});

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  @override
  Widget build(BuildContext context) {
    final Color buttonColor = const Color(0xFFD32F2F);

    final List<Map<String, String>> roles = [
      {'title': 'General Public', 'route': '/public'},
      {'title': 'Volunteer / Officer', 'route': '/volunteer'},
      {'title': 'Admin', 'route': '/admin'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Your Role",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: buttonColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: roles.map((role) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, role['route']!);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: 250,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      role['title']!,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
