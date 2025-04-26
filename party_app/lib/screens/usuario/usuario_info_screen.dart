import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/widgets/gradient_background2.dart';
import 'package:party_app/widgets/queries.dart';

class UsuarioInfoScreen extends StatefulWidget {
  const UsuarioInfoScreen({super.key});

  @override
  State<UsuarioInfoScreen> createState() => _UsuarioInfoScreenState();
}

final nameController = TextEditingController();
final lastNameController = TextEditingController();
final emailController = TextEditingController();

String? errorMessage;
Color inputsColor = const Color.fromARGB(255, 145, 152, 161);
Color inactiveColor = const Color.fromARGB(255, 145, 152, 161);
Color activeColor = Colors.white;

bool isReadOnly = true;
String editProfile = 'Editar información';

class _UsuarioInfoScreenState extends State<UsuarioInfoScreen> {
  String? uid;

    @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      loadUserInfo(); 
    } else {
      print("No hay ningún usuario autenticado");
    }
  }

  final Queries queries = Queries();
  Future<void> loadUserInfo() async {
    if (uid == null) return;
    final userInfo = await Queries.getUsuarioInfo(uid!);
    nameController.text = userInfo?['name'] ?? '';
    lastNameController.text = userInfo?['lastName'] ?? '';
    emailController.text = userInfo?['email'] ?? '';
    print(userInfo);
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    void changeColor(Color color) {
      setState(() {
        inputsColor = color;
      });
    }

    return Scaffold(
      body: GradientBackground2(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: BackButton(color: Colors.white),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 200),
                    child: Image.asset(
                      'assets/logo_title.png',
                      height: 70,
                      width: 70,
                    ),
                  ),
                ),
              ],
            ),
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
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Mi información',
                          style: GoogleFonts.robotoCondensed(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 50),
                      child: Image.asset('assets/usuario_pp.png',
                          width: 150, height: 150),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nameController,
                        readOnly: isReadOnly,
                        cursorColor: Colors.white,
                        style: TextStyle(color: inputsColor),
                        decoration: InputDecoration(
                          hintText: 'nombre(s)',
                          hintStyle:
                              TextStyle(color: inactiveColor, fontSize: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: inputsColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: inputsColor),
                          ),
                          prefixIcon:
                              Icon(Icons.person, color: inputsColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: lastNameController,
                        readOnly: isReadOnly,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: inputsColor),
                        decoration: InputDecoration(
                          hintText: 'apellido(s)',
                          hintStyle:
                              TextStyle(color: inactiveColor, fontSize: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: inputsColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: inputsColor),
                          ),
                          prefixIcon: Icon(Icons.person,
                              color: inputsColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: emailController,
                        readOnly: isReadOnly,
                        cursorColor: Colors.white,
                        style: TextStyle(color: inputsColor),
                        decoration: InputDecoration(
                          hintText: 'email',
                          hintStyle:
                              TextStyle(color: inactiveColor, fontSize: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: inputsColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: inputsColor),
                          ),
                          prefixIcon: Icon(Icons.alternate_email_rounded,
                              color: inputsColor),
                        ),
                      ),
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              fixedSize: Size(screenWidth * 0.5, 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: const Color(0xFF7A82B5)),
                          onPressed: () async {
                            bool success = await Queries.updateUsuario(
                                email: emailController.text,
                                lastName: lastNameController.text,
                                name: nameController.text,
                                uid: uid!);
                            setState(() {
                              if (editProfile == 'Editar información') {
                                changeColor(activeColor);
                                isReadOnly = false;
                                editProfile = 'Guardar';
                              } else {
                                if (success) {
                                  changeColor(inactiveColor);
                                  isReadOnly = true;
                                  editProfile = 'Editar información';
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Información actualizada'),
                                        content: const Text(
                                            'Tu información se actualizó con exito.'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            });
                          },
                          child: Text(editProfile,
                              style: GoogleFonts.robotoCondensed(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
