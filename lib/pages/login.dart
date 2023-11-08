import 'package:flutter/material.dart';
import 'package:namer_app/components/my_button.dart';
import 'package:namer_app/components/my_textfield.dart';
import 'package:namer_app/components/square_tile.dart';
import 'package:namer_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void goHome(BuildContext context) {
    Navigator.pushNamed(context, '/home');
  }

  void signIn(BuildContext context) {
    Navigator.pushNamed(context, '/signIn');
  }

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 181, 81),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // logo
              Text(
                'Iniciar Sesion',
                style: TextStyle(
                  color: Color.fromARGB(255, 121, 58, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),

              const SizedBox(height: 30),

              // welcome back, you've been missed!
              Text(
                '¡Bienvenido!',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Nombre de Usuario',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Olvidaste tu Contraseña?',
                      style: TextStyle(color: Color.fromARGB(255, 121, 58, 0)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in butto
              ElevatedButton(
                onPressed: () async {
                  final username = usernameController.text;
                  final password = passwordController.text;

                  final loginOk = await authService.login(username, password);

                  print(loginOk);

                  if (loginOk) {
                    Navigator.pushNamed(context, '/home');
                  } else {
                    print('El inicio de sesión ha fallado');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 121, 58, 0), // Color de fondo del botón
                  onPrimary: Colors.white, // Color del texto del botón
                ),
                child: Text('Iniciar Sesion'), // Puedes personalizar el texto aquí
              ),

              const SizedBox(height: 30),

              // or continue with

              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  signIn(context);
                },
                child: Row(
                  // not a member? register now
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No eres miebro?',
                      style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        signIn(context);
                      },
                      child: Text(
                        'Registro',
                        style: TextStyle(
                          color: Color.fromARGB(255, 121, 58, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
