import 'package:appnew/models/session_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ApiAuth {
  final String apiKey = 'db826b9d3c411ab9c29b46a6ca5b246e'; // Tu clave de API

  final dio = Dio();

  Future<SessionModel?> createSession(String requestToken) async {
    final String sessionUrl =
        'https://api.themoviedb.org/3/authentication/session/new?api_key=$apiKey';
    try {
      final response = await dio.post(
        sessionUrl,
        data: jsonEncode({
          'request_token': requestToken,
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

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
}
