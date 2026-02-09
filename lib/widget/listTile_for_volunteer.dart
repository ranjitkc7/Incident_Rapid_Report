// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomVListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool showDivider;

  const CustomVListTile({
    super.key,
    required this.icon,
    required this.subtitle,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon,color: iconColor ?? const Color(0xFFD32F2F)),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: textColor ?? Colors.black87,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          trailing: const Icon(
            Icons.call_end_rounded,
            size: 25,
            color: Color.fromARGB(255, 234, 6, 6),
          ),
          onTap: onTap,
        ),
        if (showDivider) const Divider(height: 1),
      ],
    );
  }
}
