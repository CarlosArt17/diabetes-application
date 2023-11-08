import 'package:flutter/material.dart';
import 'package:namer_app/pages/login.dart';
import 'package:namer_app/pages/signin.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/services/auth_service.dart';
import 'package:namer_app/services/apiservice.dart';
import 'package:namer_app/pages/predict.dart';
import 'package:namer_app/services/reservice.dart';
import 'package:namer_app/pages/retrain_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PredictionService()),
        ChangeNotifierProvider(create: (_) => FitService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/a': (context) => Login(),
        '/': (context) => Predict(),
        '/signIn': (context) => Signin(),
        '/retrain': (context) => RetrainScreen(),
      },
    );
  }
}
