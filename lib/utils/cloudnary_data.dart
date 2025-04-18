import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_app/utils/snackbar_utilis.dart';

class CloudnaryData {
  final String cloudName = 'dtfsbt44n'; // Replace with your Cloudinary Cloud Name
  final String apiKey = '838139747911737'; // Replace with your Cloudinary API Key
  final String preset = 'umerishaq'; // Replace with your Cloudinary Upload Preset

  Future<String> uploadSingleImage(File imageFile, BuildContext context) async {
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = preset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final res = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['secure_url'];
    } else {
      throw Exception('Failed to upload image');
    }
  }

  Future<List<String>> uploadMultipleImages(List<File> imageFiles, BuildContext context) async {
    List<String> imageUrls = [];

    for (var imageFile in imageFiles) {
      try {
        final url = await uploadSingleImage(imageFile, context);
        imageUrls.add(url);
      } catch (e) {
        SnackbarUtils.showCustomSnackbar(title: "Error", message: "Failed to upload one of the images.");
        debugPrint("Upload error: $e");
      }
    }

    if (imageUrls.isNotEmpty) {
      print("::::sucess");
      // SnackbarUtils.showCustomSnackbar(title: "Success", message: "All images uploaded.");
    }

    return imageUrls;
  }
}
