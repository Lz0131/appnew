import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  Future<String?> createRequestToken() async {
    final apiKey = 'db826b9d3c411ab9c29b46a6ca5b246e';
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/authentication/token/new?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['request_token'];
    } else {
      print('Error al crear el token de solicitud: ${response.statusCode}');
      return null;
    }
  }

  void redirectToTmdbAuthPage(BuildContext context, String? requestToken) {
    if (requestToken != null) {
      final authUrl = 'https://www.themoviedb.org/authenticate/$requestToken';
      print('Redireccionando a: $authUrl');
      // Aquí deberías redirigir al usuario a authUrl, según la plataforma que estés utilizando
      // Redirigir a la URL de autenticación utilizando url_launcher
      launch(authUrl).then((_) {
        // Después de que el usuario regrese de la página de autenticación, navega a la pantalla /dash
        bool loginSuccessful = true;
        if (loginSuccessful) {
          Navigator.pushReplacementNamed(context, '/recetario');
        }
      }).catchError((error) {
        print('Error al abrir la URL: $error');
        // Manejar el caso de error al abrir la URL
      });
    } else {
      // Manejar el caso de error al obtener el token de solicitud
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error al obtener el token de solicitud.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Bienvenido",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Ingresa tu informacion para iniciar sesión"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Nombre de Usuario",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Contraseña",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final requestToken = await createRequestToken();
            redirectToTmdbAuthPage(context, requestToken);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Olvidaste tu contraseña?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No tienes cuenta? "),
        TextButton(
          onPressed: () {
            // Implementa la navegación a la pantalla de registro aquí
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }
}
