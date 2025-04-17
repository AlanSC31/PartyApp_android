import 'package:flutter/material.dart';

class GradientBackground2 extends StatelessWidget {
  final Widget child;

  const GradientBackground2({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2F3C94), 
            Color(0xFF6B478C), 
          ],
          stops: [0.7, 1], 
        ),
      ),
      child: child,
    );
  }
}
