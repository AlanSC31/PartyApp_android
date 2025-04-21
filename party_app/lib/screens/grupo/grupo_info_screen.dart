import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/widgets/gradient_background2.dart';
import 'package:party_app/widgets/image_grid.dart';
import 'package:party_app/widgets/queries.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

final nameController = TextEditingController();
final emailController = TextEditingController();
final genreController = TextEditingController();
final rateController = TextEditingController();
final cardNumberController = TextEditingController();
final cardNameController = TextEditingController();
final cardDateController = TextEditingController();
final cvvController = TextEditingController();

String? errorMessage;
Color inputsColor = const Color.fromARGB(255, 145, 152, 161);
Color inactiveColor = const Color.fromARGB(255, 145, 152, 161);
Color activeColor = Colors.white;

String? errorMessageCard;
Color inputsColorCard = const Color.fromARGB(255, 145, 152, 161);
Color inactiveColorCard = const Color.fromARGB(255, 145, 152, 161);
Color activeColorCard = Colors.white;

bool isReadOnly = true;
String editProfile = 'Editar información';

bool isReadOnlyCard = true;
String editCard = 'Editar información';

class _InfoScreenState extends State<InfoScreen> {
  String? uid;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      loadUserInfo(); 
      loadCardInfo();
    } else {
      print("No hay ningún usuario autenticado");
    }
  }

  final Queries queries = Queries();
  Future<void> loadUserInfo() async {
    if (uid == null) return;
    final userInfo = await queries.getGrupoInfo(uid!);
    nameController.text = userInfo?['name'] ?? '';
    emailController.text = userInfo?['email'] ?? '';
    genreController.text = userInfo?['genre'] ?? '';
    rateController.text = (userInfo?['rate'] ?? 0.0).toStringAsFixed(2);
    print(userInfo);
  }

    Future<void> loadCardInfo() async {
    if (uid == null) return;
    final cardInfo = await queries.getCardInfo(uid!);
    cardNameController.text = cardInfo?['name'] ?? '';
    cardNumberController.text = cardInfo?['number'] ?? '';
    cardDateController.text = cardInfo?['date'] ?? '';
    cvvController.text = cardInfo?['cvv'].toString() ?? '';
    print(cardInfo);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    void _changeColor(Color color) {
      setState(() {
        inputsColor = color;
      });
    }

    void _changeColorCard(Color color) {
      setState(() {
        inputsColorCard = color;
      });
    }

    return MaterialApp(
      title: 'PartyApp',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientBackground2(
            child: SingleChildScrollView(
          child: Column(
            children: [
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
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Image.asset('assets/grupo_pp.png',
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
                            hintText: 'nombre del grupo',
                            hintStyle:
                                TextStyle(color: inactiveColor, fontSize: 15),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColor),
                            ),
                            prefixIcon:
                                Icon(Icons.groups_outlined, color: inputsColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: emailController,
                          readOnly: isReadOnly,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
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
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: genreController,
                          readOnly: isReadOnly,
                          cursorColor: Colors.white,
                          style: TextStyle(color: inputsColor),
                          decoration: InputDecoration(
                            hintText: 'genero(s)',
                            hintStyle:
                                TextStyle(color: inactiveColor, fontSize: 15),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColor),
                            ),
                            prefixIcon: Icon(Icons.music_note_outlined,
                                color: inputsColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: rateController,
                          readOnly: isReadOnly,
                          cursorColor: Colors.white,
                          style: TextStyle(color: inputsColor),
                          decoration: InputDecoration(
                            hintText: 'tarifa / hora',
                            hintStyle:
                                TextStyle(color: inactiveColor, fontSize: 15),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColor),
                            ),
                            prefixIcon: Icon(Icons.attach_money_sharp,
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
                              bool success = await Queries.updateGrupo(
                                  email: emailController.text,
                                  name: nameController.text,
                                  genre: genreController.text,
                                  rate: double.parse(rateController.text),
                                  uid: uid!);
                              setState(() {
                                if (editProfile == 'Editar información') {
                                  _changeColor(activeColor);
                                  isReadOnly = false;
                                  editProfile = 'Guardar';
                                } else {
                                  if (success) {
                                    _changeColor(inactiveColor);
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 50, right: 50, bottom: 20),
                child: Container(
                  width: double.infinity,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Metodo de pago',
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                            'aqui es donde recibiras tu pago despues de un servicio',
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 15, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: cardNumberController,
                          readOnly: isReadOnlyCard,
                          cursorColor: Colors.white,
                          style: TextStyle(color: inputsColorCard),
                          decoration: InputDecoration(
                            hintText: 'numero de tarjeta',
                            hintStyle: TextStyle(
                                color: inactiveColorCard, fontSize: 15),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColorCard),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColorCard),
                            ),
                            prefixIcon: Icon(Icons.credit_card_rounded,
                                color: inputsColorCard),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: cardNameController,
                          readOnly: isReadOnlyCard,
                          cursorColor: Colors.white,
                          style: TextStyle(color: inputsColorCard),
                          decoration: InputDecoration(
                            hintText: 'nombre en la tarjeta',
                            hintStyle: TextStyle(
                                color: inactiveColorCard, fontSize: 15),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColorCard),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: inputsColorCard),
                            ),
                            prefixIcon:
                                Icon(Icons.person, color: inputsColorCard),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                keyboardType: TextInputType.datetime,
                                controller: cardDateController,
                                readOnly: isReadOnlyCard,
                                cursorColor: Colors.white,
                                style: TextStyle(color: inputsColorCard),
                                decoration: InputDecoration(
                                  hintText: 'fecha vencimiento',
                                  hintStyle: TextStyle(
                                      color: inactiveColorCard, fontSize: 15),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: inputsColorCard),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: inputsColorCard),
                                  ),
                                  prefixIcon: Icon(Icons.date_range,
                                      color: inputsColorCard),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: cvvController,
                                readOnly: isReadOnlyCard,
                                cursorColor: Colors.white,
                                style: TextStyle(color: inputsColorCard),
                                decoration: InputDecoration(
                                  hintText: 'cvv',
                                  hintStyle: TextStyle(
                                      color: inactiveColorCard, fontSize: 15),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: inputsColorCard),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: inputsColorCard),
                                  ),
                                  prefixIcon: Icon(Icons.password,
                                      color: inputsColorCard),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                              setState(() {
                                if (editCard == 'Editar información') {
                                  _changeColorCard(activeColorCard);
                                  isReadOnlyCard = false;
                                  editCard = 'Guardar';
                                } else {
                                  if (cardDateController.text.isNotEmpty &&
                                      cardNumberController.text.isNotEmpty &&
                                      cardDateController.text.isNotEmpty &&
                                      cvvController.text.isNotEmpty) {
                                    Queries.cardRegister(
                                        name: cardNameController.text,
                                        number: cardNumberController.text,
                                        date: cardDateController.text,
                                        cvv: cvvController.text,
                                        uid: uid!);
                                    _changeColorCard(inactiveColorCard);
                                    isReadOnlyCard = true;
                                    editCard = 'Editar información';
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
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Llena todos los campos")),
                                    );
                                  }
                                }
                              });
                            },
                            child: Text(editCard,
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 50, right: 50, bottom: 20),
                child: Container(
                  width: double.infinity,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Multimedia',
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const ImageGrid()
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        )),
      ),
    );
  }
}
