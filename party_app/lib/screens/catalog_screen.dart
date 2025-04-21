// Flutter imports
// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partyapp/widgets/gradient_background.dart';
import 'package:partyapp/widgets/app_bar.dart' as custom;
import 'package:partyapp/widgets/nav_bar.dart';

/// Modelo de cada InfoCard
class InfoCardData {
  final String id;
  final String nombre;
  final String generos;
  final String disponibilidad;
  final double tarifa;
  final double rating;
  final String imageUrl;

  InfoCardData({
    required this.id,
    required this.nombre,
    required this.generos,
    required this.disponibilidad,
    required this.tarifa,
    required this.rating,
    required this.imageUrl,
  });

  factory InfoCardData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InfoCardData(
      id: doc.id,
      nombre: data['nombre'] ?? '',
      generos: data['generos'] ?? '',
      disponibilidad: data['disponibilidad'] ?? '',
      tarifa: (data['tarifa'] as num).toDouble(),
      rating: (data['rating'] as num).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}

/// Widget de la tarjeta de información (responsive)
class InfoCard extends StatelessWidget {
  final InfoCardData info;
  const InfoCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalMargin = size.width * 0.06;
    final verticalMargin = size.height * 0.015;
    final imageSize = size.width * 0.18;
    final paddingAll = size.width * 0.04;
    final fontTitle = size.width * 0.045;
    final fontSubtitle = size.width * 0.035;
    final fontPrice = size.width * 0.04;
    final starSize = size.width * 0.05;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
      padding: EdgeInsets.all(paddingAll),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              info.imageUrl,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: size.width * 0.04),

          // Texto y detalles
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.nombre,
                  style: GoogleFonts.biryani(
                    fontSize: fontTitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  info.generos,
                  style: GoogleFonts.biryani(
                    fontSize: fontSubtitle,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  info.disponibilidad,
                  style: GoogleFonts.biryani(
                    fontSize: fontSubtitle,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: size.height * 0.01),

                // Tarifa y estrellas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${info.tarifa.toStringAsFixed(2)}',
                      style: GoogleFonts.biryani(
                        fontSize: fontPrice,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < info.rating.round() ? Icons.star : Icons.star_border,
                          size: starSize,
                          color: Colors.amber,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pantalla de catálogo (responsive)
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  CatalogScreenState createState() => CatalogScreenState();
}

class CatalogScreenState extends State<CatalogScreen> {
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.06;
    final verticalPadding = size.height * 0.01;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              custom.AppBar(title: 'Catálogo'),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: TextField(
                  onChanged: (val) => setState(() => _searchTerm = val),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: GoogleFonts.biryani(
                      color: Colors.white.withOpacity(0.6),
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Listado de tarjetas
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('infoCards')
                      .where('nombre', isGreaterThanOrEqualTo: _searchTerm)
                      .where('nombre', isLessThanOrEqualTo: '$_searchTerm\uf8ff')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error cargando datos'));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final docs = snapshot.data!.docs;
                    if (docs.isEmpty) {
                      return Center(
                        child: Text(
                          'No se encontraron resultados',
                          style: GoogleFonts.biryani(color: Colors.white70),
                        ),
                      );
                    }
                    final items = docs
                        .map((d) => InfoCardData.fromDocument(d))
                        .toList();

                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: size.height * 0.12),
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        return InfoCard(info: items[i]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(currentIndex: 1),
    );
  }
}