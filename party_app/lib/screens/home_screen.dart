import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/login_screen.dart';
import 'package:party_app/widgets/gradient_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:party_app/widgets/queries.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final codeController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  Queries queries = Queries();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GradientBackground(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.40,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Image.asset(
                            'assets/logo_title.png',
                            height: 220,
                            width: 300,
                          ),
                        ),
                      ),
                      Text('HOME SCREEN',
                          style: GoogleFonts.biryani(
                              color: Colors.white, fontSize: 40)),
                      ElevatedButton(
                          onPressed: () async {
                            try {
                              auth.signOut();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('se cerró la sesión')),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            } catch (e) {
                              print('error al cerrar sesion: $e');
                            }
                          },
                          child: const Text('cerrar sesion')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
