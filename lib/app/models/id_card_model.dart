import 'dart:io';
import 'dart:convert';

class IDCardModel {
  final File imageFile; // File object representing the ID card image

  IDCardModel({
    required this.imageFile, // Accepts a File object
  });

  // Convert the file image to base64 and return a map for the POST request
  Future<Map<String, dynamic>> toJson() async {
    List<int> imageBytes = await imageFile.readAsBytes(); // Read file bytes
    String base64Image = base64Encode(imageBytes); // Encode to base64

    return {
      'image': base64Image, // Use base64-encoded string for 'image'
      'image_type': 'base64', // Indicate that the image is base64
    };
  }
}
