import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:party_app/widgets/ip_change.dart';

class Queries {
  // static String ip = '10.0.2.2'; //localhost: 10.0.2.2
  // static String grupoUrl = 'http://$ip:8082/groups';  // grupos endpoint 

  // GESTION DE USUARIOS ENDPOINTS

  // usuario register
    static Future<bool> usuarioRegister({
    required String email,
    required String nombre,
    required String apellido,
    required String password,
    required String tipo
  }) async {
    
    final ip = await BackendConfig.getBackendIp();
    final String usuarioUrl = 'http://$ip:8082/users'; // usuarios endpoint
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
      return true; 
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return false; 
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
    final ip = await BackendConfig.getBackendIp();
    final String grupoUrl = 'http://$ip:8082/groups';  // grupos endpoint 
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
        },
        body: body);

    if (response.statusCode == 200) {
      return true; 
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return false; 
    }
  }
}