import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/suggestion_model.dart';

class SuggestionService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addSuggestion(SuggestionModel suggestion) async {
    await _firestore.collection('suggestions').add({
      ...suggestion.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
