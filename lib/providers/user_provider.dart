import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  static Map<String, String> formValues = {
    'user': '',
    'password': '',
  };

  static bool huella = false;
  static late bool atenticateWithHuella;

  static final ValueNotifier<bool> profileUpdated = ValueNotifier<bool>(false);

  static Future<dynamic> getUserByName(Map<String, String> datos) async {
    // URL de la API
    final url = Uri.parse('http://201.217.78.155:6060/api/auth/login');

    final Map<String, String> datosSinEspacios =
        datos.map((key, value) => MapEntry(key, value.trim()));

    final cuerpo = json.encode(datosSinEspacios);
    final cabecera = {'Content-Type': 'application/json'};
    final respuesta = await http.post(url, headers: cabecera, body: cuerpo);
    Map<String, dynamic> mapaRespuesta = json.decode(respuesta.body);
    return mapaRespuesta;
  }

  static Future<void> updateUser(
      String user, Map<String, dynamic> updates) async {
    // URL del endpoint
    final url = Uri.parse(
        'http://201.217.78.155:6060/api/auth/updateUser/$user'); // Cambia localhost por tu IP o dominio

    try {
      await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updates), // Convertir el mapa a JSON
      );
    } catch (e) {
      // print('Error de conexión: $e');
    }
  }

  static Future<dynamic> getUser(String user) async {
    // URL del endpoint
    //192.168.148.34
    final url = Uri.parse('http://201.217.78.155:6060/api/auth/user/$user');

    try {
      // Realizar la petición GET
      final respuesta = await http.get(url);

      // Verificar el código de estado de la respuesta
      if (respuesta.statusCode == 200) {
        // Decodificar el cuerpo de la respuesta en JSON
        return jsonDecode(respuesta.body);
      } else {
        // Manejar errores HTTP
        return {
          'error': 'Error en la solicitud',
          'statusCode': respuesta.statusCode,
          'mensaje': respuesta.reasonPhrase
        };
      }
    } catch (e) {
      // Manejar excepciones de conexión
      return {
        'error': 'Error de conexión',
        'mensaje': e.toString(),
      };
    }
  }

  static setFormValues(Map<String, String?> newFormValues) {
    formValues['user'] = (newFormValues['user'] ?? formValues['user'])!;
    formValues['password'] =
        (newFormValues['password'] ?? formValues['password'])!;
  }

  static setHuella(bool setHuella) {
    huella = setHuella;
  }
}
