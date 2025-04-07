import 'package:flutter/material.dart';
import 'package:party_app/widgets/gradient_background.dart';
import 'package:google_fonts/google_fonts.dart';

class GrupoRegister extends StatefulWidget {
  const GrupoRegister({super.key});

  @override
  State<GrupoRegister> createState() => _GrupoRegisterState();
}

class _GrupoRegisterState extends State<GrupoRegister> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final genreController = TextEditingController();
  final rateController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(  
        child: Column(
          children: [
            Expanded(  
              child: GradientBackground(  
                child: SingleChildScrollView(  
                  child: Column(
                    children: [
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),  
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                              child: TextField(
                                controller: emailController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'correo',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 20),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(
                                      Icons.alternate_email_outlined,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                              child: TextField(
                                controller: passwordController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'contraseña',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 20),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(Icons.password_sharp,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                              child: TextField(
                                controller: nameController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'nombre(s)',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 20),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(Icons.person_2_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                              child: TextField(
                                controller: genreController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'apellido(s)',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 20),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(Icons.person_2_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                                                        Padding(
                              padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: rateController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'tarifa / hora',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 20),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(Icons.person_2_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.white
                                          .withOpacity(.2),
                                  fixedSize: Size(screenWidth * 0.7, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'enviar',
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
    );
  }
}
