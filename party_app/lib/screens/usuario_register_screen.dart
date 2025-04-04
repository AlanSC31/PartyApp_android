import 'package:flutter/material.dart';
import 'package:party_app/widgets/gradient_background.dart';

import 'package:google_fonts/google_fonts.dart';

class UsuarioRegister extends StatefulWidget {
  const UsuarioRegister({super.key});

  @override
  State<UsuarioRegister> createState() => _UsuarioRegisterState();
}

class _UsuarioRegisterState extends State<UsuarioRegister> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GradientBackground(
          child: Center(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.40,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        'PartyApp',
                        style: GoogleFonts.kronaOne(color: Colors.white,
                        fontSize: 50),
                      ),
                    ),
                  )
                  
                ],
              ),
            ),
            Container(height: screenHeight * 0.60),
          ],
        ),
      )),
    );
  }
}
