import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FitService with ChangeNotifier {
  final String baseUrl = 'https://api.github.com/repos/carlosart17/diabetes-model/dispatches';

  Future<void> retrainModel(String datasetUrl, String sha) async {
    final Uri url = Uri.parse(baseUrl);
    print(url);

    final requestBody = {
      "event_type": "ml_ci_cd",
      "client_payload": {
        "dataseturl": datasetUrl,
        "sha": sha, // Utiliza el valor pasado como argumento
      }
    };
    print(jsonEncode(requestBody));

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer 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', // Asegúrate de que el token sea correcto
        'Accept': 'application/vnd.github.v3+json',
        'Content-type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 204) {
      print("Evento enviado con éxito");
    } else {
      print("Error al enviar el evento: ${response.statusCode}");
    }
  }
}
