import 'package:flutter/material.dart';
import 'package:namer_app/components/my_button.dart';
import 'package:namer_app/components/my_textfield.dart';
import 'package:namer_app/components/square_tile.dart';
import 'package:namer_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class Signin extends StatelessWidget {
  Signin({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void enterUser(BuildContext context) {
    Navigator.pushNamed(context, '/home');
  }

  void logIn(BuildContext context) {
    Navigator.pushNamed(context, '/');
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
                'Registro',
                style: TextStyle(
                  color: Color.fromARGB(255, 121, 58, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),

              const SizedBox(height: 50),

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
                controller: emailController,
                hintText: 'Correo electronico',
                obscureText: false,
              ),

              MyTextField(
                controller: usernameController,
                hintText: 'Nombre de usuario',
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
                      'Olvidaste tu contrseña?',
                      style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // sign in button
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text;
                  final username = usernameController.text;
                  final password = passwordController.text;

                  final loginOk =
                      await authService.register(email, username, password);

                  print(loginOk);

                  if (loginOk) {
                    Navigator.pushNamed(context, '/home');
                  } else {
                    print('El inicio de sesión ha fallado');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 121, 58, 0), // Color de fondo del botón
                  onPrimary: Color.fromARGB(255, 255, 255, 255), // Color del texto del botón
                ),
                child: Text('Registrarse'), // Puedes personalizar el texto aquí
              ),

              const SizedBox(height: 30),

              // or continue with
              

              const SizedBox(height: 25),

              InkWell(
                onTap: () {
                  logIn(context);
                },
                child: Row(
                  // a member? register now
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ya eres mienbro?',
                      style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Inicio de Sesion',
                      style: TextStyle(
                        color: Color.fromARGB(255, 121, 58, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
