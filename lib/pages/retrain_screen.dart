import 'package:flutter/material.dart';
import 'package:namer_app/services/reservice.dart';

class RetrainScreen extends StatefulWidget {
  @override
  _RetrainScreenState createState() => _RetrainScreenState();
}

class _RetrainScreenState extends State<RetrainScreen> {
  final FitService fitService = FitService();
  final TextEditingController shaController = TextEditingController();

  // Mapa de opciones y URLs
  Map<String, String> datasetOptions = {
    "CSV 100%": "https://firebasestorage.googleapis.com/v0/b/diabetes-model-ef5e7.appspot.com/o/diabetes_prediction_100.csv?alt=media&token=49dae355-51aa-4fa0-838d-f103c9b1f425",
    "CSV 50%": "https://firebasestorage.googleapis.com/v0/b/diabetes-model-ef5e7.appspot.com/o/diabetes_prediction_50.csv?alt=media&token=a43e9102-f31d-4467-9c31-9ac691dd8324",
    "CSV 25%": "https://firebasestorage.googleapis.com/v0/b/diabetes-model-ef5e7.appspot.com/o/diabetes_prediction_25.csv?alt=media&token=e5b9a159-a014-4a2a-bd34-27c91083feb9"
    // Agrega más opciones y URLs aquí
  };

  String? selectedOption; // Opción seleccionada
  Color backgroundColor = Color.fromARGB(255, 235, 181, 81); // Color de fondo
  Color buttonColor = Color.fromARGB(255, 121, 58, 0); // Color del botón

  @override
  void dispose() {
    shaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reentrenar Modelo'),
      ),
      body: Container(
        color: backgroundColor, // Cambia el color de fondo
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Lista de opciones con radios
              Column(
                children: datasetOptions.entries.map((entry) {
                  final option = entry.key;
                  final url = entry.value;
                  return ListTile(
                    title: Text(option),
                    leading: Radio(
                      value: option,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value as String;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        selectedOption = option;
                      });
                    },
                  );
                }).toList(),
              ),
              // Campo de entrada para el "sha"
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: shaController,
                  decoration: InputDecoration(labelText: 'SHA'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _retrainModel();
                },
                style: ElevatedButton.styleFrom(
                  primary: buttonColor, // Cambia el color del botón
                ),
                child: const Text('Reentrenar Modelo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _retrainModel() async {
    if (selectedOption == null) {
      // Si no se selecciona ninguna opción, muestra un mensaje de error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, seleccione una opción.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Obtiene el "sha" ingresado por el usuario
    final sha = shaController.text;

    if (sha.isEmpty) {
      // Si no se proporciona un "sha", muestra un mensaje de error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, proporcione un SHA.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Obtiene la URL correspondiente a la opción seleccionada
    final selectedUrl = datasetOptions[selectedOption]!;

    // Envía la opción seleccionada, la URL y el "sha" para el reentrenamiento
    await fitService.retrainModel(selectedUrl, sha);

    // Puedes agregar lógica adicional aquí, como mostrar un mensaje de éxito.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reentrenamiento completado'),
          content: Text('Se reentrenó el modelo con éxito.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
