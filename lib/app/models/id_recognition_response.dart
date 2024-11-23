import 'package:dafa/app/models/id_card_data.dart';

class IDRecognitionResponse {
  final int errorCode;
  final String errorMessage;
  final List<IDCardData> data;

  IDRecognitionResponse({
    required this.errorCode,
    required this.errorMessage,
    required this.data,
  });

  factory IDRecognitionResponse.fromJson(Map<String, dynamic> json) {
    return IDRecognitionResponse(
      errorCode: json['errorCode'],
      errorMessage: json['errorMessage'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((item) => IDCardData.fromJson(item))
          .toList(),
    );
  }
}