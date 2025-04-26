import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_app/widgets/gradient_background2.dart';
import 'package:party_app/widgets/queries.dart';

class GrupoChatDetail extends StatefulWidget {
  final String otherUserUid;

  const GrupoChatDetail({super.key, required this.otherUserUid});

  @override
  State<GrupoChatDetail> createState() => _GrupoChatDetailState();
}

class _GrupoChatDetailState extends State<GrupoChatDetail> {
  final TextEditingController _controller = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  late final String chatId;

  @override
  void initState() {
    super.initState();
    chatId = _getChatId(currentUser.uid, widget.otherUserUid);
  }

  String _getChatId(String user1, String user2) {
    return user1.hashCode <= user2.hashCode
        ? '${user1}_$user2'
        : '${user2}_$user1';
  }

  void _sendMessage() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      Queries.sendMessage(
          chatId: chatId, text: message, senderId: currentUser.uid);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF7A82B5),
        title: FutureBuilder<Map<String, dynamic>?>(
          future: Queries.getUsuarioInfo(widget.otherUserUid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Cargando...");
            }
            if (snapshot.hasData) {
              final data = snapshot.data!;
              final nombre = data['name'] ?? '';
              final apellido = data['lastName'] ?? '';
              return Text(
                "$nombre $apellido",
                style: GoogleFonts.biryani(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              );
            } else {
              return const Text("Chat con usuario");
            }
          },
        ),
      ),
      body: GradientBackground2(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Has sido contratado, ponte en contacto con el usuario para cumplir con el servicio!', style: GoogleFonts.biryani(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Queries.getMessages(chatId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final data =
                          messages[index].data() as Map<String, dynamic>;
                      final isMe = data['senderId'] == currentUser.uid;
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Colors.greenAccent
                                : Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(data['message'] ?? '',
                              style: GoogleFonts.biryani(color: Colors.black)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder
                          .none, // Esto es opcional si no quieres borde
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
