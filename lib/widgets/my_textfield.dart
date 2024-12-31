import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String? hint;
  final IconData? icon;
  const MyTextfield({super.key,  this.hint,  this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
