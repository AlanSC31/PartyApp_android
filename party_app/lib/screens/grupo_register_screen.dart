import 'package:flutter/material.dart';
import 'package:party_app/screens/email_verification.dart';
import 'package:party_app/widgets/authentication.dart';
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


  final auth = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    genreController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                        height: screenHeight * 0.3,
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
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'correo electronico',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 15),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(
                                      Icons.alternate_email_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: TextField(
                                obscureText: true,
                                controller: passwordController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'contraseña',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 15),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(Icons.password_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: TextField(
                                controller: nameController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'nombre del grupo',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 15),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(Icons.groups_outlined,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: TextField(
                                controller: genreController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'genero(s)',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 15),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(Icons.music_note_outlined,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: TextField(
                                controller: genreController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'tarifa / hora',
                                  hintStyle: GoogleFonts.biryani(
                                      color: Colors.white, fontSize: 15),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 206, 205, 205)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(Icons.attach_money_sharp,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final result = await auth.registerWithEmail(
                                      emailController.text,
                                      passwordController.text,
                                      context);

                                  if (result != null) {
                                    final user = result.user;

                                    if (user != null && !user.emailVerified) {
                                      await user.sendEmailVerification();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Se envió un correo de verificación a ${user.email}')),
                                      );
                                    }

                                    print(
                                        "Registro exitoso. UID: ${result.user?.uid}");
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const EmailVerification()),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(.3),
                                  fixedSize: Size(screenWidth * 0.7, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
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
