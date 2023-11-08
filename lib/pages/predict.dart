import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/services/apiservice.dart';
import 'package:namer_app/services/reservice.dart';
import 'package:namer_app/pages/retrain_screen.dart';

class Predict extends StatefulWidget {
  const Predict({Key? key}) : super(key: key);

  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  final PredictionService apiService =
      PredictionService(); // Usar la clase PredictionService
  final _formKey = GlobalKey<FormState>();

  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController hypertensionController = TextEditingController();
  TextEditingController heartdiseaseController = TextEditingController();
  TextEditingController smokinghistoryController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController hbA1clevelController = TextEditingController();
  TextEditingController bloodglucoselevelController = TextEditingController();
  TextEditingController predictionController = TextEditingController();
  int genero = 0;
  double edad = 0.0;
  int hipertension = 0;
  int parocardiaco = 0;
  int historialfumador = 0;
  double bmi = 0.0;
  double hbA1clevel = 0.0;
  double bloodglucoselevel = 0.0;
  String prediction = '';

  @override
  void initState() {
    super.initState();
    genderController.addListener(() {
      final text = genderController.text;
      if (text.isNotEmpty) {
        try {
          final value = int.parse(text);
          setState(() {
            genero = value;
          });
        } catch (e) {
          genderController.text = genero.toString();
        }
      }
    });

    ageController.addListener(() {
      final text = ageController.text;
      if (text.isNotEmpty) {
        try {
          final value = double.parse(text);
          setState(() {
            edad = value;
          });
        } catch (e) {
          ageController.text = edad.toString();
        }
      }
    });

    hypertensionController.addListener(() {
      final text = hypertensionController.text;
      if (text.isNotEmpty) {
        try {
          final value = int.parse(text);
          setState(() {
            hipertension = value;
          });
        } catch (e) {
          hypertensionController.text = hipertension.toString();
        }
      }
    });

    heartdiseaseController.addListener(() {
      final text = heartdiseaseController.text;
      if (text.isNotEmpty) {
        try {
          final value = int.parse(text);
          setState(() {
            parocardiaco = value;
          });
        } catch (e) {
          heartdiseaseController.text = parocardiaco.toString();
        }
      }
    });

    smokinghistoryController.addListener(() {
      final text = smokinghistoryController.text;
      if (text.isNotEmpty) {
        try {
          final value = int.parse(text);
          setState(() {
            historialfumador = value;
          });
        } catch (e) {
          smokinghistoryController.text = historialfumador.toString();
        }
      }
    });

    bmiController.addListener(() {
      final text = bmiController.text;
      if (text.isNotEmpty) {
        try {
          final value = double.parse(text);
          setState(() {
            bmi = value;
          });
        } catch (e) {
          bmiController.text = bmi.toString();
        }
      }
    });

    hbA1clevelController.addListener(() {
      final text = hbA1clevelController.text;
      if (text.isNotEmpty) {
        try {
          final value = double.parse(text);
          setState(() {
            hbA1clevel = value;
          });
        } catch (e) {
          hbA1clevelController.text = hbA1clevel.toString();
        }
      }
    });

    bloodglucoselevelController.addListener(() {
      final text = bloodglucoselevelController.text;
      if (text.isNotEmpty) {
        try {
          final value = double.parse(text);
          setState(() {
            bloodglucoselevel = value;
          });
        } catch (e) {
          bloodglucoselevelController.text = bloodglucoselevel.toString();
        }
      }
    });
  }

  @override
  void dispose() {
    genderController.dispose();
    ageController.dispose();
    hypertensionController.dispose();
    heartdiseaseController.dispose();
    smokinghistoryController.dispose();
    bmiController.dispose();
    hbA1clevelController.dispose();
    bloodglucoselevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediccion'),
      ),
      body: Container(
        color: Color.fromARGB(255, 235, 181, 81), // Cambia el color de fondo según tus preferencias
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: genderController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Genero'),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Por favor, ingresa un valor.';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Edad'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Por favor, ingresa un valor.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: hypertensionController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Hipertensión'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Por favor, ingresa un valor.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: heartdiseaseController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Paro cardiaco'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Por favor, ingresa un valor.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: smokinghistoryController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Historial fumador'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Por favor, ingresa un valor.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: bmiController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'BMI'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Por favor, ingresa un valor.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: hbA1clevelController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Hemoglobina'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Por favor, ingresa un valor.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: bloodglucoselevelController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Glocosa en sangre'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Por favor, ingresa un valor.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller:
                      predictionController, // Utiliza el controlador para establecer y actualizar el valor.
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Predicción'),
                ),
                SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RetrainScreen()),
                      );
                      
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 121, 58, 0), // Cambia el color del botón según tus preferencias
                    ),
                    child: const Text('Re entrenar'),
                  ),
                SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Map<String, dynamic> result =
                            await apiService.predictClothingSize(
                          gender: genero,
                          age: edad,
                          hypertension: hipertension,
                          heartdisease: parocardiaco,
                          smokinghistory: historialfumador,
                          bmi: bmi,
                          hbA1clevel: hbA1clevel,
                          bloodglucoselevel: bloodglucoselevel,
                        );
                        final prediction =
                            result['prediction']; // Obtén la predicción del JSON
          
                        predictionController.text = prediction
                            .toString(); // Actualiza el valor del controlador con la predicción.
                        // Actualiza el valor del controlador con la predicción.
                        // Actualiza el valor del controlador con la predicción.
          
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('Datos enviados'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('Genero: $genero'),
                                  Text('Edad: $edad'),
                                  Text('Hipertension: $hipertension'),
                                  Text('Paro cardiaco: $parocardiaco'),
                                  Text('Historial fumador: $historialfumador'),
                                  Text('BMI: $bmi'),
                                  Text('Hemoglobina: $hbA1clevel'),
                                  Text('Glocosa en sangre: $bloodglucoselevel'),
                                  Text('Predicción: $result'),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: const Text('Cerrar'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 121, 58, 0), // Cambia el color del botón según tus preferencias
                    ),
                    child: const Text('Predecir'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}