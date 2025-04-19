import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:party_app/widgets/ip_change.dart';

class Queries {
  // static String ip = '10.0.2.2'; //localhost: 10.0.2.2
  // static String grupoUrl = 'http://$ip:8082/groups';  // grupos endpoint

  // GESTION DE USUARIOS ENDPOINTS

  // usuario register
  static Future<bool> usuarioRegister(
      {required String email,
      required String nombre,
      required String apellido,
      required String password,
      required String tipo,
      required String uid}) async {
    final ip = await BackendConfig.getBackendIp();
    final String usuarioUrl = 'http://$ip:8082/users'; // usuarios endpoint
    final url = Uri.parse('$usuarioUrl/usuario-register');

    final body = jsonEncode({
      "name": nombre,
      "lastName": apellido,
      "email": email,
      "password": password,
      "type": tipo,
      "uid": uid,
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
    required String uid,
  }) async {
    final ip = await BackendConfig.getBackendIp();
    final String grupoUrl = 'http://$ip:8082/groups'; // grupos endpoint
    final url = Uri.parse('$grupoUrl/grupo-register');

    final body = jsonEncode({
      "name": nombre,
      "genre": genero,
      "email": email,
      "password": password,
      "type": tipo,
      "rate": rate,
      "uid": uid,
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

  // grupo info
  Future<Map<String, dynamic>?> getGrupoInfo(String uid) async {
    final ip = await BackendConfig.getBackendIp();
    final String grupoUrl = 'http://$ip:8082/groups'; // grupos endpoint
    final url = Uri.parse('$grupoUrl/info?uid=$uid');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexion: $e');
    }
    return null;
  }

  // update grupo info
  static Future<bool> updateGrupo(
      {required String name,
      required String email,
      required String genre,
      required double rate,
      required String uid}) async {
    final ip = await BackendConfig.getBackendIp();
    final String grupoUrl = 'http://$ip:8082/groups'; // grupos endpoint
    final url = Uri.parse('$grupoUrl/grupo-update');

    final body = jsonEncode({
      "name": name,
      "email": genre,
      "genre": email,
      "rate": rate,
      "uid": uid,
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

  // card register
  static Future<bool> cardRegister({
    required String name,
    required String number,
    required String date,
    required String cvv,
    required String uid,
  }) async {
    final ip = await BackendConfig.getBackendIp();
    final String grupoUrl = 'http://$ip:8082/cards';
    final url = Uri.parse('$grupoUrl/card-register');

    final body = jsonEncode({
      "name": name,
      "number": number,
      "date": date,
      "cvv": cvv,
      "uid": uid,
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

  static Future<bool> updateCard({
    required String name,
    required String number,
    required String date,
    required String cvv,
    required String uid,
  }) async {
    final ip = await BackendConfig.getBackendIp();
    final String cardUrl = 'http://$ip:8082/cards';
    final url = Uri.parse('$cardUrl/card-update?uid=$uid');

    final body = jsonEncode({
      "name": name,
      "number": number,
      "date": date,
      "cvv": cvv,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return false;
    }
  }

  // card info
  Future<Map<String, dynamic>?> getCardInfo(String uid) async {
    final ip = await BackendConfig.getBackendIp();
    final String cardUrl = 'http://$ip:8082/cards'; // grupos endpoint
    final url = Uri.parse('$cardUrl/info?uid=$uid');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexion: $e');
    }
    return null;
  }
}
