<<<<<<< HEAD

import 'package:flutter/material.dart';
import 'package:party_app/screens/usuario_register_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
=======
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:party_app/screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
>>>>>>> feature/usuario_register_screen
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: UsuarioRegister(),
    );
  }
}
=======
      home: LandingScreen(),
    );
  }
}
>>>>>>> feature/usuario_register_screen
