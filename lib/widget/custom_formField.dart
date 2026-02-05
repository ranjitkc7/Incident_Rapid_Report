// ignore_for_file: dead_code
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    required this.label,
    required this.icon,
    required this.obscureText,
    this.onToggle,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    required this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: onToggle != null
            ? IconButton(
                onPressed: onToggle,
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,

        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1.2,
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(width: 1.0, color: Colors.red.shade400),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: Colors.red.shade400, width: 1.2),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(width: 1.2, color: Colors.grey.shade400),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(width: 0.0, color: Colors.grey.shade400),
        ),

        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
