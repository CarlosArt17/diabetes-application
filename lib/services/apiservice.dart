import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PredictionService with ChangeNotifier {
  final String baseUrl = 'https://ml-service-carlosart17.cloud.okteto.net';

  Future<Map<String, dynamic>> predictClothingSize(
      {required int gender,
      required double age,
      required int hypertension,
      required int heartdisease,
      required int smokinghistory,
      required double bmi,
      required double hbA1clevel,
      required double bloodglucoselevel}) async {
    final Uri url = Uri.parse('$baseUrl/score');

    final Map<String, dynamic> requestBody = {
      'gender': gender,
      'age': age,
      'hypertension': hypertension,
      'heart_disease': heartdisease,
      'smoking_history': smokinghistory,
      'bmi': bmi,
      'HbA1c_level': hbA1clevel,
      'blood_glucose_level': bloodglucoselevel
    };

    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Error al consumir la API de predicción ${response.statusCode}');
    }
  }
}
