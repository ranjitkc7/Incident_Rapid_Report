import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../../utils/incident_util.dart';

class IncidentCard extends StatelessWidget {
  final Map<String, dynamic> incidentData;
  final Position? userPosition;

  const IncidentCard({
    super.key,
    required this.incidentData,
    required this.userPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 6, left: 12, right: 12, top: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (incidentData["imageUrl"] != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                incidentData["imageUrl"],
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,

                loadingBuilder: (context, child, loadingprogress) {
                  if (loadingprogress == null) return child;
                  return SizedBox(
                    height: 180,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingprogress.expectedTotalBytes != null
                            ? loadingprogress.cumulativeBytesLoaded /
                                  loadingprogress.expectedTotalBytes!
                            : null,
                        color: const Color(0xFFD32F2F),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, StackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.wifi_off, size: 40, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          "Image not available",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning, color: Color(0xFFD32F2F)),
                    const SizedBox(width: 8),
                    Text(
                      incidentData["incidentType"] ?? "Unknown Incident",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (incidentData["severity"] != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    "Severity: ${incidentData["severity"]}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        incidentData["address"] ?? " ",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                Text(
                  incidentData["description"] ?? "No description provided.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),

                if (incidentData["createdAt"] != null)
                  Text(
                    _formatTime(incidentData["createdAt"]),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                const SizedBox(height: 4),
                if (incidentData["createdAt"] != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        calculateDistance(userPosition, incidentData),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        timeAgoFormat(incidentData["createdAt"]),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
