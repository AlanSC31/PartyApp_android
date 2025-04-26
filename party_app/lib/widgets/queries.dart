import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:party_app/widgets/ip_change.dart';
import 'package:party_app/widgets/profile_model.dart';

class Queries {
  // static String ip = '10.0.2.2'; //localhost: 10.0.2.2
  // static String grupoUrl = 'http://$ip:8082/groups';  // grupos endpoint

  // GESTION DE USUARIOS ENDPOINTS

// login redirect
  static Future<String?> getAccountType(String email) async {
    final ip = await BackendConfig.getBackendIp();
    final String usuarioUrl = 'http://$ip:8082/users'; // usuarios endpoint
    final url = Uri.parse('$usuarioUrl/type?email=$email');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['type'];
    } else {
      return null;
    }
  }

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

  // usuario info
  static Future<Map<String, dynamic>?> getUsuarioInfo(String uid) async {
    final ip = await BackendConfig.getBackendIp();
    final String usuarioUrl = 'http://$ip:8082/users'; // grupos endpoint
    final url = Uri.parse('$usuarioUrl/info?uid=$uid');

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

  // update usuario info
  static Future<bool> updateUsuario(
      {required String name,
      required String lastName,
      required String email,
      required String uid}) async {
    final ip = await BackendConfig.getBackendIp();
    final String usuarioUrl = 'http://$ip:8082/users'; // grupos endpoint
    final url = Uri.parse('$usuarioUrl/usuario-update');

    final body = jsonEncode({
      "name": name,
      "lastName": lastName,
      "email": email,
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
  static Future<Map<String, dynamic>?> getGrupoInfo(String uid) async {
    final ip = await BackendConfig.getBackendIp();
    final String grupoUrl = 'http://$ip:8082/groups'; 
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

// catalogo queries

// create profile
  static Future<bool> createProfile({
    required String name,
    required String availability,
    required String genre,
    required String rate,
    required String uid,
  }) async {
    final ip = await BackendConfig.getBackendIp();
    final String catalogUrl = 'http://$ip:8084/profiles';
    final url = Uri.parse('$catalogUrl/profile-create');

    final body = jsonEncode({
      "name": name,
      "availability": availability,
      "genre": genre,
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

// show profiles
  static final StreamController<List<Profile>> _profileStreamController =
      StreamController<List<Profile>>.broadcast();

  static Stream<List<Profile>> get profileStream =>
      _profileStreamController.stream;

  static Future<void> fetchProfiles() async {
    final ip = await BackendConfig.getBackendIp();
    final String profileUrl = 'http://$ip:8084/profiles/profile-retrieve';

    try {
      final response = await http.get(
        Uri.parse(profileUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Profile> profiles = data
            .map((e) => Profile.fromJson(e))
            .where((profile) => profile.availability != 'no disponible')
            .toList();
        _profileStreamController.add(profiles);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        _profileStreamController.addError('Error al obtener perfiles');
      }
    } catch (e) {
      print('Error de conexión: $e');
      _profileStreamController.addError('Error de conexión');
    }
  }

  static void dispose() {
    _profileStreamController.close();
  }

  // profile by uid
  static Future<Profile?> fetchProfileByUid(String uid) async {
    final ip = await BackendConfig.getBackendIp();
    final String profileUrl = 'http://$ip:8084/profiles';
    final url = Uri.parse('$profileUrl/profile-retrieve-by-uid?uid=$uid');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Profile.fromJson(data);
      } else {
        print(
            'Error al obtener perfil por UID: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión al obtener perfil por UID: $e');
      return null;
    }
  }

static Future<String?> checkAval(String uid) async {
  final ip = await BackendConfig.getBackendIp();
  final String profileUrl = 'http://$ip:8084/profiles';
  final url = Uri.parse('$profileUrl/check-aval?uid=$uid');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Imprimir la respuesta para verificar qué tipo de contenido se recibe
    print(response.body);

    if (response.statusCode == 200) {
      // Aquí manejamos las respuestas de texto simple
      return response.body; // Esto devuelve el texto plano recibido
    } else {
      print('Error al verificar disponibilidad: ${response.statusCode} - ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error de conexión al verificar disponibilidad: $e');
    return null;
  }
}

 // change availability
static Future<bool> changeAval({
  required String uid,
  required String aval,
}) async {
  final ip = await BackendConfig.getBackendIp();
  final String profileUrl = 'http://$ip:8084/profiles';
  final url = Uri.parse('$profileUrl/change-aval?uid=$uid&disponibilidad=$aval');  

  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error al cambiar disponibilidad: ${response.statusCode} - ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error de conexión al cambiar disponibilidad: $e');
    return false;
  }
}

// CHAT
static Future<void> sendMessage({
  required String chatId,
  required String senderId,
  required String text,
}) async {
  final message = {
    'senderId': senderId,
    'message': text,
    'timestamp': FieldValue.serverTimestamp(),
  };

  await FirebaseFirestore.instance
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .add(message);
}

static Stream<QuerySnapshot> getMessages(String chatId) {
  return FirebaseFirestore.instance
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .orderBy('timestamp', descending: false)
      .snapshots();
}


}
