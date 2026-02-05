import 'package:flutter/material.dart';
import '../../widget/custom_button.dart';
import '../../service/suggestion_service.dart';
import '../../model/suggestion_model.dart';


class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final TextEditingController suggestionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suggestion Page", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFD32F2F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: suggestionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Suggestion",
                hintText: "Please! Enter your Opinion...",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
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
            const SizedBox(height: 20),
            CustomButton(
              text: "Submit",
              onPressed: () async {
                final suggestionText = suggestionController.text.trim();

                if (suggestionText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Suggestion cannot be empty",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Color(0xFFD32F2F),
                    ),
                  );
                  return;
                }
                try {
                  final suggestion = SuggestionModel(
                    description: suggestionText,
                  );
                  await SuggestionService.addSuggestion(suggestion);

                  suggestionController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Suggestion submitted successfully",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Failed to submit suggestion: $e",
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Color(0xFFD32F2F),
                    ),
                  );
                }
              },
              color: Colors.white,
              radius: 12,
              width: double.infinity,
              bgColor: const Color(0xFFD32F2F),
            ),
          ],
        ),
      ),
    );
  }
}
