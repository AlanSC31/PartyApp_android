import 'package:flutter/material.dart';
import 'package:party_app/widgets/ip_change.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadIp();
  }

  void _loadIp() async {
    String currentIp = await BackendConfig.getBackendIp();
    _controller.text = currentIp;
  }

  void _saveIp() async {
    await BackendConfig.setBackendIp(_controller.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('IP guardada correctamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Dirección IP del backend:'),
            TextField(controller: _controller),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveIp,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
