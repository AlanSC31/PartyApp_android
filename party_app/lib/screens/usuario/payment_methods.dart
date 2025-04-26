import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/widgets/authentication.dart';
import 'package:party_app/widgets/gradient_background2.dart';
import 'package:party_app/widgets/queries.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
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

class _PaymentMethodsState extends State<PaymentMethods> {
  String? uid;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    } else {
      print("No hay ningún usuario autenticado");
    }
  }

  final Queries queries = Queries();

  Future<void> loadCardInfo() async {
    if (uid == null) return;
    final cardInfo = await queries.getCardInfo(uid!);
    cardNameController.text = cardInfo?['name'] ?? '';
    cardNumberController.text = cardInfo?['number'] ?? '';
    cardDateController.text = cardInfo?['date'] ?? '';
    cvvController.text = cardInfo?['cvv'].toString() ?? '';
    print(cardInfo);
  }

  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    void changeColorCard(Color color) {
      setState(() {
        inputsColorCard = color;
      });
    }

    return Scaffold(
       appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Mis tarjetas'),
        backgroundColor: const Color(0xFF7A82B5),
        elevation: 1,
      ),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 30, right: 30, bottom: 20),
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
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                            'aqui es donde recibiras tu pago despues de un servicio',
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 20, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
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
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
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
                        padding: const EdgeInsets.only(top: 50, bottom: 20),
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
                                  changeColorCard(activeColorCard);
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
                                    changeColorCard(inactiveColorCard);
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
            ],
          ),
        )),
      );
  }
}
