// chat_screen.dart
// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partyapp/widgets/gradient_background.dart';
import 'package:partyapp/widgets/app_bar.dart' as custom;
import 'package:partyapp/widgets/nav_bar.dart';

/// Modelo de mensaje
class MessageData {
  final String id;
  final String text;
  final String senderId;
  final Timestamp timestamp;

  MessageData({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
  });

  factory MessageData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageData(
      id: doc.id,
      text: data['text'] ?? '',
      senderId: data['senderId'] ?? '',
      timestamp: data['timestamp'] as Timestamp,
    );
  }
}

/// Bubble de mensaje responsivo
class MessageBubble extends StatelessWidget {
  final MessageData message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxBubbleWidth = size.width * 0.7;
    final horizontalPadding = size.width * 0.04;
    final verticalPadding = size.height * 0.01;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding / 2,
      ),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxBubbleWidth),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: isMe ? Colors.white : Colors.white70,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(isMe ? 18 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 18),
            ),
          ),
          child: Text(
            message.text,
            style: GoogleFonts.biryani(
              fontSize: size.width * 0.04,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

/// Pantalla de chat
class ChatScreen extends StatefulWidget {
  final String chatId;
  final String contactName;

  const ChatScreen({super.key, required this.chatId, required this.contactName});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final String _currentUserId = 'myUserId'; // TODO: reemplazar con FirebaseAuth

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .add({
      'text': text,
      'senderId': _currentUserId,
      'timestamp': Timestamp.now(),
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              custom.AppBar(title: 'Chat'),
              // Nombre de contacto debajo del AppBar
              Container(
                width: double.infinity,
                color: Colors.white24,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.contactName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.biryani(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: Colors.white,
                  ),
                ),
              ),

              // Mensajes
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(widget.chatId)
                      .collection('messages')
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error cargando mensajes', style: TextStyle(color: Colors.white70)));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final docs = snapshot.data!.docs;
                    final messages = docs.map((d) => MessageData.fromDocument(d)).toList();

                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
                      itemCount: messages.length,
                      itemBuilder: (ctx, i) {
                        final msg = messages[i];
                        final isMe = msg.senderId == _currentUserId;
                        return MessageBubble(message: msg, isMe: isMe);
                      },
                    );
                  },
                ),
              ),

              // Campo de escritura
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Escribir',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white24,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),

              // Espacio para NavBar
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(currentIndex: 2),
    );
  }
}