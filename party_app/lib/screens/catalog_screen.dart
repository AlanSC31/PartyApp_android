import 'package:flutter/material.dart';
import 'package:party_app/widgets/gradient_background.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: GradientBackground(
            child: Stack(
              children: [
                // Barra Nav Bottom
                Positioned(
                  left: 0,
                  top: screenHeight * 0.90,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.10,
                    decoration: BoxDecoration(
                      color: const Color(0x59FFF7F7),
                    ),
                  ),
                ),
                // Search bar
                Positioned(
                  left: screenWidth * 0.12,
                  top: screenHeight * 0.12,
                  child: Container(
                    width: screenWidth * 0.76,
                    height: screenHeight * 0.045,
                    decoration: ShapeDecoration(
                      color: Colors.white.withAlpha(89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                // Texto "Search" en la barra de búsqueda
                Positioned(
                  left: screenWidth * 0.14,
                  top: screenHeight * 0.12,
                  child: SizedBox(
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.045,
                    child: Opacity(
                      opacity: 0.41,
                      child: Text(
                        'Search',
                        style: GoogleFonts.biryani(
                          color: const Color(0xFFFBF8F8),
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                // Top Bar
                Positioned(
                  left: screenWidth * 0.12,
                  top: screenHeight * 0.02,
                  child: Container(
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://placehold.co/37x37"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                // Título "Catalogo" en la parte superior
                Positioned(
                  left: screenWidth * 0.3,
                  top: screenHeight * 0.025,
                  child: SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.06,
                    child: Text(
                      'Catalogo',
                      style: GoogleFonts.biryani(
                        color: const Color(0xFFFBF8F8),
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                // Info Card
                Positioned(
                  left: screenWidth * 0.14,
                  top: screenHeight * 0.20,
                  child: Container(
                    width: screenWidth * 0.70,
                    height: screenHeight * 0.20,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // Contenido INFO CARD
                  ),
                ),
                // Continúa adaptando el resto de widgets...
              ],
            ),
            ),
          );
        },
      ),
    );
  }
}