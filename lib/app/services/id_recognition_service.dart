import 'dart:convert';
import 'package:dafa/app/core/values/app_consts.dart';
import 'package:dafa/app/models/id_recognition_response.dart';
import 'package:http/http.dart' as http;

class IDRecognitionService {
  final String apiUrl =
      "https://api.fpt.ai/vision/idr/vnm"; // Replace with the correct endpoint
  final String apiKey =
      AppConsts.FPT_AI_API_KEY; // Replace with your actual API key

  Future<IDRecognitionResponse?> recognizeIDCard(String imagePath) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      request.headers['api_key'] = apiKey;
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseData);
        return IDRecognitionResponse.fromJson(jsonResponse);
      } else {
        print(
            'Failed to recognize ID card. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error recognizing ID card: $e');
      return null;
    }
  }
}
