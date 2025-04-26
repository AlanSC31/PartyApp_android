import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/grupo/grupo_chat_screen.dart';
import 'package:party_app/screens/grupo/grupo_info_screen.dart';
import 'package:party_app/widgets/queries.dart';

class GrupoHomeScreen extends StatefulWidget {
  const GrupoHomeScreen({super.key});

  @override
  State<GrupoHomeScreen> createState() => _GrupoHomeScreenState();
}

class _GrupoHomeScreenState extends State<GrupoHomeScreen> {
  String? uid;
  String availability = 'no disponible';
    @override
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      _checkAvailability(uid!); // Verifica la disponibilidad al iniciar
    } else {
      print("No hay ningún usuario autenticado");
    }
  }
    void _checkAvailability(String uid) async {
    String? status = await Queries.checkAval(uid);
    setState(() {
    availability = status ?? 'no disponible'; // Actualiza el estado de disponibilidad
    });
  }
  static const List<String> _appBarTitles = [
    'Información del grupo',
    'Mensajes',
    'Solicitudes',
    'Mi perfil',
  ];

  int _selectedIndex = 0;

List<Widget> _widgetOptions() {
  return <Widget>[
    const InfoScreen(),
    const GrupoChat(),
    const GrupoChat(),
  ];
}

    // Cambiar disponibilidad
  void _changeAvailability(String uid) async {
    String newAvailability = availability == 'disponible' ? 'no disponible' : 'disponible';

    bool success = await Queries.changeAval(uid: uid, aval: newAvailability);

    if (success) {
      setState(() {
        availability = newAvailability; // Actualiza el estado de disponibilidad
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Disponibilidad cambiada a $newAvailability')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cambiar disponibilidad')),
      );
    }
  }

void _showChangeAvailDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('¿Quieres cambiar tu disponibilidad?'),
        content: const Text('Quieres activar o desactivar tu disponibilidad?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _changeAvailability(uid!);
              Navigator.of(context).pop();
            },
            child: const Text('Sí'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}

  void _onItemTapped(int index) {
    if (index == 1) {
      // Aquí va la lógica para cambiar la disponibilidad
      _showChangeAvailDialog();
      // También podrías abrir un modal, por ejemplo:
      // showModalBottomSheet(...);
      return; // No actualices la pantalla
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7A82B5),
        elevation: 1,
        title: Text(
          _appBarTitles[_selectedIndex],
          style: GoogleFonts.biryani(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
  child: _selectedIndex == 1
      ? const Text('') // o un widget vacío si no quieres mostrar nada
      : _widgetOptions()[_selectedIndex],
),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.groups_2,
            ),
            label: 'Información',
          ),
          BottomNavigationBarItem(
            icon: Icon(availability == 'disponible' ? 
              Icons.toggle_on : Icons.toggle_off,
              color: availability == 'disponible' ? Colors.green : Colors.red, 
              size: 40,
              
            ),
            label: availability, 
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chat',
          ),
        ],
        backgroundColor: const Color(0xFF7A82B5),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}
