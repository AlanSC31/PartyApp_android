import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/config/changeIpScreen.dart';
import 'package:party_app/screens/login_screen.dart';
import 'package:party_app/screens/register_screen.dart';
import 'package:party_app/widgets/gradient_background.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _tapCounter = 0;
  DateTime? _lastTapTime;

  void _handleLogoTap() {
    final now = DateTime.now();

    if (_lastTapTime == null || now.difference(_lastTapTime!) > const Duration(seconds: 2)) {
      _tapCounter = 1;
    } else {
      _tapCounter++;
    }

    _lastTapTime = now;

    if (_tapCounter == 5) {
      _tapCounter = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'PartyApp',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: GradientBackground(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: GestureDetector(
                              onTap: _handleLogoTap,
                              child: Image.asset(
                                'assets/logo_title.png',
                                height: 300,
                                width: 300,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor',
                              style: GoogleFonts.biryani(color: Colors.white)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                            indent: 40,
                            endIndent: 40,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 40, left: 20, right: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white.withOpacity(.4),
                                    fixedSize: Size(screenWidth * 0.7, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'iniciar sesión',
                                    style: GoogleFonts.biryani(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 40, left: 20, right: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const RegisterScreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white.withOpacity(.4),
                                    fixedSize: Size(screenWidth * 0.7, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'registrarme',
                                    style: GoogleFonts.biryani(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
