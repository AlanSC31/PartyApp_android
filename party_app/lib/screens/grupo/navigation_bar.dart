import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/grupo/chat_screen.dart';
import 'package:party_app/screens/grupo/info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Icons.groups_2,
            ),
            label: 'Información',
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
