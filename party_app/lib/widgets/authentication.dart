import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // Necesario para ScaffoldMessenger

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // register
  Future<UserCredential?> registerWithEmail(
      String email, String password, BuildContext context) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Error al registrar: ${e.code} - ${e.message}");

      // Mostrar el Snackbar desde aquí
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Error desconocido durante el registro'),
          backgroundColor: Colors.red, 
          duration: const Duration(seconds: 3),
        ),
      );

      return null;
    }
  }

  // login
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Error al iniciar sesión: ${e.code} - ${e.message}");
      return null;
    }
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // is user logged?
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
