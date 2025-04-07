import 'package:flutter/material.dart';
import 'package:party_app/screens/code_verification.dart';
import 'package:party_app/widgets/gradient_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioRegister extends StatefulWidget {
  const UsuarioRegister({super.key});

  @override
  State<UsuarioRegister> createState() => _UsuarioRegisterState();
}

class _UsuarioRegisterState extends State<UsuarioRegister> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  String verificationId = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendCode() async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await auth.signInWithCredential(credential);
          print("✅ Verificación automática completada");
        },
        verificationFailed: (FirebaseAuthException e) {
          print("❌ Error de verificación: ${e.message}");
        },
        codeSent: (String verId, int? resendToken) {
          setState(() {
            verificationId = verId;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CodeVerification()),
          );
          print("📩 Código enviado al número: ${phoneNumberController.text}");
        },
        codeAutoRetrievalTimeout: (String verId) {
          setState(() {
            verificationId = verId;
          });
        },
      );
    } catch (e) {
      print("❌ Error al enviar código: $e");
    }
  }

  // @override
  // void dispose() {
  //   phoneNumberController.dispose();
  //   passwordController.dispose();
  //   nameController.dispose();
  //   lastNameController.dispose();
  //   super.dispose();
  // }

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
                              padding: const EdgeInsets.only(
                                  top: 20, left: 40, right: 40),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: phoneNumberController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'numero celular',
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
                                      Icons.phone_android_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 40, right: 40),
                              child: TextField(
                                controller: nameController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'nombre(s)',
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
                                  prefixIcon: const Icon(Icons.person_2_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 40, right: 40),
                              child: TextField(
                                controller: lastNameController,
                                cursorColor: Colors.white,
                                style: GoogleFonts.biryani(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'apellido(s)',
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
                                  prefixIcon: const Icon(Icons.person_2_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  sendCode();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(.2),
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
