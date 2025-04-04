
import 'package:flutter/material.dart';
import 'package:party_app/widgets/gradient_background.dart';

class UsuarioRegister extends StatefulWidget {
  const UsuarioRegister({super.key});

  @override
  State<UsuarioRegister> createState() => _UsuarioRegisterState();
}

class _UsuarioRegisterState extends State<UsuarioRegister> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradientBackground(child: Center()),
    );
     
  }
}