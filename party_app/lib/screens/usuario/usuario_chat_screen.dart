import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/screens/usuario/usuario_chat_detail.dart';
import 'package:party_app/widgets/gradient_background2.dart';
import 'package:party_app/widgets/queries.dart';  

class UsuarioChat extends StatefulWidget {
  const UsuarioChat({super.key});

  @override
  State<UsuarioChat> createState() => _UsuarioChatState();
}

class _UsuarioChatState extends State<UsuarioChat> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final Map<String, String> _nombreCache = {};

  Stream<QuerySnapshot> getUserChatsStream() {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: currentUser!.uid)
        .snapshots();
  }

Future<String> getNombreGrupo(String uid) async {
  if (_nombreCache.containsKey(uid)) return _nombreCache[uid]!;

  final usuarioInfo = await Queries.getGrupoInfo(uid); // Tu función existente

  if (usuarioInfo != null) {
    final nombre = usuarioInfo['name'] ?? '';
    final nombreCompleto = '$nombre';

    _nombreCache[uid] = nombreCompleto;
    return nombreCompleto;
  } else {
    return 'Desconocido';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground2(
        child: StreamBuilder<QuerySnapshot>(
          stream: getUserChatsStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final chats = snapshot.data!.docs;

            if (chats.isEmpty) {
              return const Center(
                child: Text(
                  "Aún no tienes chats 📨",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                final participants = List<String>.from(chat['participants']);
                final otherUserUid = participants.firstWhere(
                  (uid) => uid != currentUser!.uid,
                  orElse: () => 'Desconocido',
                );

                return FutureBuilder<String>(
                  future: getNombreGrupo(otherUserUid),
                  builder: (context, snapshot) {
                    final nombre = snapshot.data ?? 'Cargando...';

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        color: Colors.white.withOpacity(0.1),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          title: Text(
                            "Grupo: \n $nombre",
                            style: GoogleFonts.biryani(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          
                          trailing: const Icon(Icons.chat, color: Colors.white),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UsuarioChatDetail(
                                  otherUserUid: otherUserUid,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
