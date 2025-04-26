import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/usuario/banda_details_screen.dart';
import 'package:party_app/widgets/gradient_background2.dart';
import 'package:party_app/widgets/profile_model.dart';
import 'package:party_app/widgets/queries.dart';
import 'package:party_app/widgets/search_bar.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Profile> _allProfiles = [];
  List<Profile> _filteredProfiles = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Queries.fetchProfiles();
    Queries.profileStream.listen((profiles) {
      if (mounted) {
        setState(() {
          _allProfiles = profiles;
          _filteredProfiles = profiles;
        });
      }

      for (var profile in profiles) {
        print(
            'Perfil: ${profile.name}, Disponibilidad: ${profile.availability}');
      }
    });
  }

void _filterProfiles(String query) {
  setState(() {
    _filteredProfiles = _allProfiles.where((profile) {
      return (profile.name.toLowerCase().contains(query.toLowerCase()) ||
              profile.genre.toLowerCase().contains(query.toLowerCase())) &&
          profile.availability.toLowerCase() == 'disponible'; // Filtrar por disponibilidad
    }).toList();
  });
  print("Perfiles filtrados: ${_filteredProfiles.length}"); // Verifica cuántos perfiles están siendo mostrados
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground2(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              child: CustomSearchBar(
                controller: _searchController,
                onChanged: (text) {
                  _filterProfiles(text);
                },
              ),
            ),
            Expanded(
                child: StreamBuilder<List<Profile>>(
              stream: Queries.profileStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || _filteredProfiles.isEmpty) {
                  return Center(
                    child: Text(
                      'No hay perfiles disponibles',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                List<Profile> availableProfiles = snapshot.data!
                    .where((profile) =>
                        profile.availability.toLowerCase() == 'disponible')
                    .toList();

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 20),
                  itemCount: availableProfiles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BandDetailScreen(
                              uid: availableProfiles[index].uid,
                            ),
                          ),
                        );
                      },
                      child: _buildProfileCard(availableProfiles[index]),
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(Profile profile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 50,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              'assets/usuario_pp.png', // Imagen del perfil
              width: 100,
              height: 100,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre del grupo',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    profile.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Género(s)',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Text(
                    profile.genre,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Text(
                  //   'Disponibilidad',
                  //   style: TextStyle(
                  //     color: Colors.white.withOpacity(0.8),
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                  // Text(
                  //   profile.availability,
                  //   style: TextStyle(
                  //     color:
                  //         profile.availability.toLowerCase() == 'no disponible'
                  //             ? Colors.red
                  //             : Colors.green,
                  //     fontSize: 18,
                  //   ),
                  // ),
                  const SizedBox(height: 10),

                  // Tarifa
                  Text(
                    'Tarifa / hora',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '\$${profile.rate.toString()}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildReadOnlyField(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      readOnly: true,
      controller: TextEditingController(text: value),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}
