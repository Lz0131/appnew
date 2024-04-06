import 'package:appnew/models/session_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});
  final apiKey = '3938bb20bfc049bd98f27c2c2c365ed6';

  final dio = Dio();

  Future<SessionModel?> createSession(String requestToken) async {
    print('\n_________________________\n');
    print('\nEntra al metodo createSession\n');
    print('\n_________________________\n');
    final String sessionUrl =
        'https://api.themoviedb.org/3/authentication/token/validate_with_login';
    print('\n_________________________\n');
    print('\nSe creo la variable\n');
    print('\n_________________________\n');
    try {
      final response = await dio.post(
        sessionUrl,
        data: jsonEncode({
          'username': 'Dulce0131',
          'password': 'Taquitos.al.Pastor.&25221915&',
          'request_token': requestToken,
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      print('\n_________________________\n');
      print('\nSale se response\n');
      print('\n&response\n');
      print('\n_________________________\n');
      if (response.statusCode == 200) {
        final data = response.data;
        return SessionModel.fromMap(data);
      } else {
        print('Error al crear la sesión: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error al crear la sesión: $e');
      return null;
    }
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), // Duración de la notificación
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<String?> getAccountId(String sessionId) async {
    final String accountUrl =
        'https://api.themoviedb.org/3/account?api_key=$apiKey&session_id=$sessionId';
    try {
      final response = await dio.get(accountUrl);
      if (response.statusCode == 200) {
        final data = response.data;
        return data['id'].toString(); // ID de la cuenta
      } else {
        print(
            'Error al obtener la información de la cuenta: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error al obtener la información de la cuenta: $e');
      return null;
    }
  }

  Future<String?> createRequestToken() async {
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
      print('\n_________________________\n');
      print('\n el requestToken si esta');
      final authUrl =
          'https://www.themoviedb.org/authenticate/$requestToken?redirect_to=http://localhost/callback';
      print('Redireccionando a: $authUrl');
      print('\n_________________________\n');
      launch(authUrl).then((_) {
        // Después de que el usuario regrese de la página de autenticación,
        // crea una sesión y obtén el accountId
        print('\n_________________________\n');
        print('\n HASTA AQUI ESTA BIEN');
        createSession(requestToken).then((sessionId) {
          if (sessionId != null) {
            print('\n_________________________\n');
            print('\n SESSIONIon EXISTE');
            getAccountId(sessionId.sessionId).then((accountId) async {
              if (accountId != null) {
                print('accountId: $accountId');
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('accountId', accountId);
                //Navigator.pushReplacementNamed(context, '/recetario');
              } else {
                // Mostrar notificación de error

                showSnackBar(context, 'Error al obtener el accountId');
              }
            });
          } else {
            // Mostrar notificación de error
            print('\n_________________________\n');
            print('\n SESSIONIon NO EXISTE');
            showSnackBar(context, 'Error al crear la sesión');
          }
        });
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
            // final requestToken = await createRequestToken();
            print('\n_________________________\n');
            //print(requestToken);
            print('\n_________________________\n');
            print('\n hasta aqui todo va bien 1');
            //redirectToTmdbAuthPage(context, requestToken);
            Navigator.pushReplacementNamed(context, '/recetario');
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
