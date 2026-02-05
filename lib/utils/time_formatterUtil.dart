import 'package:cloud_firestore/cloud_firestore.dart';

String timeAgoFormat(Timestamp timestamp) {
  final DateTime incidentTime = timestamp.toDate();
  final Duration difference = DateTime.now().difference(incidentTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else {
    return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
  }
}