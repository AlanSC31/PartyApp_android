import 'package:shared_preferences/shared_preferences.dart';

class BackendConfig {
  static const _key = 'backend_ip';

  static Future<void> setBackendIp(String ip) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, ip);
  }

  static Future<String> getBackendIp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? '10.0.2.2'; // IP por defecto
  }
}
