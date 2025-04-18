import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:party_app/screens/email_verification.dart';
import 'package:party_app/screens/grupo/navigation_bar.dart';
import 'package:party_app/widgets/authentication.dart';
import 'package:party_app/widgets/gradient_background.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

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
                        child: const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: BackButton(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Image.asset(
                            'assets/logo_title.png',
                            height: 300,
                            width: 300,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        padding: const EdgeInsets.only(top: 40),
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
                                    borderSide: BorderSide(color: Colors.white),
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
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: const Icon(Icons.password_rounded,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text('Olvide mi contraseña',
                                    style: GoogleFonts.biryani(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold))),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final result = await auth.signInWithEmail(
                                    emailController.text,
                                    passwordController.text,
                                  );

                                  if (result != null) {
                                    await FirebaseAuth.instance.currentUser
                                        ?.reload();
                                    final user =
                                        FirebaseAuth.instance.currentUser;

                                    if (user != null && user.emailVerified) {
                                      // Todo bien, va al Home
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const HomeScreen()),
                                      );
                                    } else {
                                      // Correo no verificado
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Por favor, verifica tu correo antes de ingresar.")),
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EmailVerification()),
                                      );
                                    }
                                  } else {
                                    // Error de login
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Correo o contraseña incorrectos.")),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(.4),
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
