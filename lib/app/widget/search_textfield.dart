import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;

  const SearchTextField({Key? key, required this.controller, this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(25),
      color: Colors.white,
      elevation: 2.0,
      shadowColor: Colors.grey,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            prefixIcon: const Icon(Icons.search, color: Colors.black),
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            hintText: hint,
            fillColor: Colors.white70),
      ),
    );
  }
}
