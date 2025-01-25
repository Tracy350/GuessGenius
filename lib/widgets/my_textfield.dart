
import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextStyle? textstyle;
  const MyTextfield({
    super.key,
    this.hint,
    this.icon,
    this.keyboardType,
    this.textstyle,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textstyle,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon != null
            ? Icon(
                icon,
                size: 18, // Adjust size to minimize spacing
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        isDense: true, // Reduces internal height of the TextField
      ),
    );
  }
}
