// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  const NavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home_screen');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/catalog_screen');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/chats_screen');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/user_screen');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white.withOpacity(0.2),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      onTap: (i) => _onTap(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),  label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.book),  label: 'Catálogo'),
        BottomNavigationBarItem(icon: Icon(Icons.chat),  label: 'Chats'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Perfil'),
      ],
    );
  }
}
