import 'package:flutter/material.dart';
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
    });
  }

  void _filterProfiles(String query) {
    setState(() {
      _filteredProfiles = _allProfiles.where((profile) {
        return profile.name.toLowerCase().contains(query.toLowerCase()) ||
            profile.genre.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
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
                  _filterProfiles(text); // Filtrar perfiles cuando el texto cambie
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
                    return const Center(child: Text('No hay perfiles disponibles'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _filteredProfiles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print(_filteredProfiles[index].uid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BandDetailScreen(
                                uid: _filteredProfiles[index].uid, 
                              ),
                            ),
                          );
                        },
                        child: _buildProfileCard(_filteredProfiles[index]),
                      );
                    },
                  );
                },
              ),
            ),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    'Género',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w400 ,
                    ),
                  ),
                  
                  Text(
                    profile.genre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                   const SizedBox(height: 10),

                  // Disponibilidad con color verde
                  Text(
                    'Disponibilidad',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    profile.availability,
                    style: TextStyle(
                      color: profile.availability.toLowerCase() == 'no disponible'
                          ? Colors.red
                          : Colors.green,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Tarifa
                  Text(
                    'Tarifa / hora',
                    style:  TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '\$${profile.rate.toString()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
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

