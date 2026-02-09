// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:incident_response_app/model/volunteer_model.dart';
import 'package:incident_response_app/screens/volunteer/dropdown_field.dart';
import 'package:incident_response_app/screens/volunteer/volunteer_data_page.dart';
import 'package:incident_response_app/service/volunteer_data_service.dart';
import 'package:incident_response_app/widget/custom_button.dart';
import 'package:incident_response_app/widget/custom_formField.dart';

class AddVolunteerPage extends StatefulWidget {
  const AddVolunteerPage({super.key});

  @override
  State<AddVolunteerPage> createState() => _AddVolunteerPageState();
}

class _AddVolunteerPageState extends State<AddVolunteerPage> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final fieldController = TextEditingController();
  String? selectedField;

  Future<void> _addVolunteer() async {
    if (nameController.text.trim().isEmpty ||
        numberController.text.trim().isEmpty ||
        selectedField == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await VolunteerDataService.addVolunteer(
        VolunteerModel(
          volunteerName: nameController.text.trim(),
          volunteerNumber: numberController.text.trim(),
          volunteerField: selectedField!,
        ),
      );
      nameController.clear();
      numberController.clear();
      fieldController.clear();

      setState(() {
        selectedField = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Volunteer added successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Add Volunteer",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD32F2F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Center(
            child: Card(
              elevation: 6,
              shadowColor: Colors.black.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Row(
                      children: const [
                        Icon(Icons.person_add_alt_1, color: Color(0xFFD32F2F)),
                        SizedBox(width: 8),
                        Text(
                          "Volunteer Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),
                    const Divider(),

                    const SizedBox(height: 12),
                    CustomFormField(
                      label: "Volunteer Name",
                      icon: Icons.person_outline,
                      obscureText: false,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                    ),

                    const SizedBox(height: 10),
                    CustomFormField(
                      label: "Phone Number",
                      icon: Icons.phone_outlined,
                      obscureText: false,
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
                    DropdownField(
                      value: selectedField,
                      onChange: (value) {
                        setState(() {
                          selectedField = value;
                          fieldController.text = value ?? "";
                        });
                      },
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: Color(0xFFD32F2F)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Preview",
                              style: TextStyle(
                                color: Color(0xFFD32F2F),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            text: "Save",
                            onPressed: _addVolunteer,
                            color: Colors.white,
                            radius: 10,
                            width: double.infinity,
                            bgColor: const Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Show Volunteer",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VolunteerDataPage(),
                          ),
                        );
                      },
                      color: Colors.white,
                      radius: 12,
                      width: double.infinity,
                      bgColor: const Color(0xFFD32F2F),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
