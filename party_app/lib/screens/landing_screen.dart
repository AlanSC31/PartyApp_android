import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartyApp',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 500,
            height: 900,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF405DE6),
                  Color(0xFF465AE3),
                  Color(0xFF4C57E1),
                  Color(0xFF6748CA),
                  Color(0xFF943EA7),
                  Color(0xFFC82D62),
                  Color(0xFFE2253F),
                  Color(0xFFEC4E3B),
                  Color(0xFFF47E40),
                  Color(0xFFFFDC80)
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Stack(
              children: [
                // Título "PartyApp"
                Positioned(
                  left: 75,
                  top: 250,
                  child: SizedBox(
                    width: 400,
                    height: 70,
                    child: Text(
                      'PartyApp',
                      style: GoogleFonts.kronaOne(
                        textStyle: TextStyle(fontSize: 40, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                        )
                        ),
                    ),
                  ),
                ),
                // Imagen del logo
                Positioned(
                  left: 100,
                  top: 273,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/PartyAppLogo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Espacio reservado (SizedBox)
                const Positioned(
                  left: 50,
                  top: 60,
                  child: SizedBox(width: 500, height: 472),
                ),
                // Botón "Iniciar sesion"
                Positioned(
                  left: 35,
                  top: 600,
                  child: Container(
                    width: 330,
                    height: 65,
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                // Texto Boton Iniciar Sesion
                Positioned(
                  left: 115,
                  top: 620,
                  child: SizedBox(
                    width: 230,
                    height: 40,
                    child: Text(
                      'Iniciar sesion',
                      style: GoogleFonts.biryani(
                        color: Color(0xFFFBF8F8),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Botón "Registrarme"
                Positioned(
                  left: 35,
                  top: 700,
                  child: Container(
                    width: 330,
                    height: 65,
                    decoration: ShapeDecoration(
                      color: const Color(0x33FFF7F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                //Texto Boton Registrarme
                Positioned(
                  left: 115,
                  top: 720,
                  child: Text(
                    'Registrarme',
                      style: GoogleFonts.biryani(
                        color: Color(0xFFFBF8F8),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
                // Línea decorativa
                Positioned(
                  left: 20,
                  top: 550,
                  child: Container(
                    width: 355,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.white,
                        ),
                      ),
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