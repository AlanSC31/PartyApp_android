import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController? controller;

  const CustomSearchBar({
    Key? key,
    required this.onChanged,
    this.hintText = 'Buscar...',
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(28),
      child: TextField(
        controller: controller,
        onChanged: onChanged, // Esta es la función que se llama cada vez que cambia el texto
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    controller!.clear(); // Limpiar el campo de texto
                    onChanged(''); // Pasar texto vacío para filtrar todo
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
