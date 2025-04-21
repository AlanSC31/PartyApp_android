import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/grupo/grupo_chat_screen.dart';
import 'package:party_app/screens/usuario/usuario_account.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  static const List<String> _appBarTitles = [
    'Mi información',
    'Mensajes',
    'Solicitudes',
    'Mi perfil',
  ];

  int _selectedIndex = 0;

  List<Widget> _widgetOptions() {
    return <Widget>[
      const AccountUserScreen(),
      const GrupoChat(),
      // MessagesTutor(userEmail: widget.email),
      // MyProfile(userEmail: widget.email),
    ];
  }

  void _onItemTapped(int index) {
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
        child: _widgetOptions()[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Cuenta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chat',
          ),
        ],
        backgroundColor: const Color(0xFF7A82B5),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
      ),
    );
  }
}
