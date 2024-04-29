import 'package:flutter/material.dart';

snackbar(String text, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xFF2AB0A9),
    margin: const EdgeInsets.all(10),
    clipBehavior: Clip.hardEdge,
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.black, fontFamily: 'Ashi', fontWeight: FontWeight.w500),
    ),
  ));
}
