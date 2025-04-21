import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/landing_screen.dart';
import 'package:party_app/screens/usuario/usuario_info_screen.dart';
import 'package:party_app/widgets/authentication.dart';
import 'package:party_app/widgets/gradient_background2.dart';

class AccountUserScreen extends StatefulWidget {
  const AccountUserScreen({super.key});

  @override
  State<AccountUserScreen> createState() => _AccountUserScreenState();
}

class _AccountUserScreenState extends State<AccountUserScreen> {
  final auth = AuthService();

  // Método para mostrar cuadro de confirmación
  void _showConfirmLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Estás seguro?'),
          content: const Text('¿Quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cerrar sesión
                auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingScreen()),
                );
              },
              child: const Text('Sí'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de confirmación
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'PartyApp',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientBackground2(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 60, left: 50, right: 50, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 50,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Image.asset(
                            'assets/usuario_pp.png',
                            width: 150,
                            height: 150,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              fixedSize: Size(screenWidth * 0.5, 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: const Color(0xFF7A82B5),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UsuarioInfoScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Mi información',
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              fixedSize: Size(screenWidth * 0.5, 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: const Color(0xFF7A82B5),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Mis metodos de pago',
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              fixedSize: Size(screenWidth * 0.5, 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: const Color.fromARGB(255, 226, 86, 76),
                            ),
                            onPressed: () {
                              // Mostrar el cuadro de confirmación
                              _showConfirmLogoutDialog();
                            },
                            child: Text(
                              'Cerrar sesión',
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
