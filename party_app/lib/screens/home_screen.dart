import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/login_screen.dart';
import 'package:party_app/widgets/gradient_background.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final codeController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

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
                            child: BackButton(color: Colors.white),
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
                      Text('USUARIO HOME',
                          style: GoogleFonts.biryani(
                              color: Colors.white, fontSize: 40)),
                      ElevatedButton(
                          onPressed: () {
                            try {
                              auth.signOut();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('se cerro la sesion')),
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
