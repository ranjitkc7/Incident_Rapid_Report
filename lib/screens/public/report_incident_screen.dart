// ignore_for_file: depend_on_referenced_packages, deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../../service/incident_report_service.dart';
import '../../service/location_service.dart';
import '../../service/image_upload.dart';
import '../../model/incident_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportIncidentScreen extends StatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  State<ReportIncidentScreen> createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  String? selectedIncident;
  File? selectedImage;
  Position? currentPosition;
  String? currentAddress;
  bool isLoadingLocation = false;
  final TextEditingController descriptionController = TextEditingController();
  String _severity = "Low";
  bool isSubmitting = false;

  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> getCurrentLocation() async {
    setState(() => isLoadingLocation = true);

    try {
      final position = await LocationService.getCurrentPosition();
      final address = await LocationService.getAddress(position);

      setState(() {
        currentPosition = position;
        currentAddress = address;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Location access denied",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoadingLocation = false);
    }
  }

  bool _validData() {
    if (selectedIncident == null || currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Select incident & location",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> submitReport() async {
    if (!_validData()) return;

    setState(() => isSubmitting = true);

    try {
      String? imageUrl;
      if (selectedImage != null) {
        imageUrl = await ImageUploadService().uploadImageToImgBB(
          selectedImage!,
        );
        if (imageUrl == null) {
          throw Exception("Image upload failed");
        }
      }
      final report = IncidentReport(
        incidentType: selectedIncident!,
        description: descriptionController.text.trim(),
        severity: _severity,
        reporterId: userId,
        latitude: currentPosition!.latitude,
        longitude: currentPosition!.longitude,
        address: currentAddress,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
      );
      await IncidentReportService.submitIncidentReport(report.toMap());
      setState(() {
        isSubmitting = false;
        selectedIncident = null;
        selectedImage = null;
        currentPosition = null;
        currentAddress = null;
        descriptionController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Report  Successfully",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
      debugPrint(e.toString());
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rapid Report Incident",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD32F2F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              value: selectedIncident,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              icon: const Icon(Icons.arrow_drop_down_circle),
              iconEnabledColor: const Color(0xFFD32F2F),
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
              onChanged: (value) {
                setState(() {
                  selectedIncident = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Incident Type",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFD32F2F),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Severity Level",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                RadioListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  activeColor: Theme.of(context).primaryColor,
                  title: const Text("Low"),
                  value: "Low",
                  groupValue: _severity,
                  onChanged: (value) => {
                    setState(() {
                      _severity = value!;
                    }),
                  },
                ),
                RadioListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  activeColor: Theme.of(context).primaryColor,
                  title: const Text("Medium"),
                  value: "Medium",
                  groupValue: _severity,
                  onChanged: (value) => {
                    setState(() {
                      _severity = value!;
                    }),
                  },
                ),
                RadioListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  activeColor: Theme.of(context).primaryColor,
                  title: const Text("High"),
                  value: "High",
                  groupValue: _severity,
                  onChanged: (value) => {
                    setState(() {
                      _severity = value!;
                    }),
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextFormField(
              maxLines: 4,
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Briefly explain what happened",
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFD32F2F),
                    width: 1.5,
                  ),
                ),
                hintStyle: TextStyle(color: Colors.grey.shade500),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: getCurrentLocation,
              label: const Text(
                "Use Current Location",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              icon: Icon(Icons.location_on, color: Colors.white, size: 20),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            if (currentAddress != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_pin, color: Color(0xFFD32F2F)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        currentAddress!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Add Photo", style: TextStyle(fontSize: 16)),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            if (selectedImage != null)
              Container(
                margin: const EdgeInsets.only(top: 12),
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    selectedImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: isSubmitting ? null : submitReport,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: isSubmitting
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text(
                      "Submit Report",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
