import 'package:flutter/material.dart';
import 'package:party_app/widgets/gradient_background2.dart';

class GrupoChat extends StatefulWidget {
  const GrupoChat({super.key});

  @override
  State<GrupoChat> createState() => _GrupoChatState();
}

class _GrupoChatState extends State<GrupoChat> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientBackground2(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('data'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
