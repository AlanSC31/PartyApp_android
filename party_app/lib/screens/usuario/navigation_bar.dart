import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/usuario/catalogo.dart';
import 'package:party_app/screens/usuario/usuario_chat_screen.dart';
import 'package:party_app/screens/usuario/usuario_account.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  static const List<String> _appBarTitles = [
    'Catalogo',
    'Mensajes',
    'Mi cuenta',
  ];

  int _selectedIndex = 0;

  List<Widget> _widgetOptions() {
    return <Widget>[
      const Catalog(),
      const UsuarioChat(),
      const AccountUserScreen(),

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
              Icons.music_note_rounded,
            ),
            label: 'Catalogo',
          ),
                    BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Mi cuenta',
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
