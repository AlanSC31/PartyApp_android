import 'dart:convert';
import 'package:http/http.dart' as http;

class Queries {
  static String ip = '10.0.2.2'; //localhost: 10.0.2.2
  static String usuarioUrl = 'http://$ip:8082/users'; // usuarios endpoint
  static String grupoUrl = 'http://$ip:8082/groups';  // grupos endpoint 

  // GESTION DE USUARIOS ENDPOINTS

  // usuario register
    static Future<bool> usuarioRegister({
    required String email,
    required String nombre,
    required String apellido,
    required String password,
    required String tipo
  }) async {
    final url = Uri.parse('$usuarioUrl/usuario-register');

    final body = jsonEncode({
      "name": nombre,
      "lastName": apellido,
      "email": email,
      "password": password,
      "type": tipo,
    });

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          // 'uthorization': basicAuth,
        },
        body: body);

    if (response.statusCode == 200) {
      return true; // Registro exitoso
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return false; // Error en el registro
    }
  }


  // grupo register
    static Future<bool> grupoRegister({
    required String email,
    required String nombre,
    required String genero,
    required String password,
    required String tipo,
    required double rate,
  }) async {
    final url = Uri.parse('$grupoUrl/grupo-register');

    final body = jsonEncode({
      "name": nombre,
      "genre": genero,
      "email": email,
      "password": password,
      "type": tipo,
      "rate": rate,
    });

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          // 'uthorization': basicAuth,
        },
        body: body);

    if (response.statusCode == 200) {
      return true; // Registro exitoso
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return false; // Error en el registro
    }
  }
}