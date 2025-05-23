import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child; // El contenido que irá dentro del fondo

  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF405DE6),
            Color(0xFF465AE3),
            Color(0xFF4C57E1),
            Color(0xFF6849CA),
            Color(0xFF943FA7),
            Color(0xFFC92E62),
            Color(0xFFE32540),
            Color(0xFFED4E3B),
            Color(0xFFF47F40),
            Color(0xFFFFDC80),
          ],
          stops: [
            0.02, 0.14, 0.26, 0.36, 0.48, 0.59, 0.69, 0.79, 0.88, 0.99,
          ],
        ),
      ),
      child: child, // Aquí va el contenido de la pantalla
    );
  }
}
