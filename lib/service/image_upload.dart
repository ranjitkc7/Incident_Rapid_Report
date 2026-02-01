import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ImageUploadService {
  Future<String?> uploadImageToImgBB(File imageFile) async {
    const String apiKey = "be4efd47ceb7473793154d51d6afbffb";

    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse("https://api.imgbb.com/1/upload"),
      body: {"key": apiKey, "image": base64Image},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["data"]["url"];
    } else {
      debugPrint("ImgBB upload failed: ${response.body}");
      return null;
    }
  }
}
