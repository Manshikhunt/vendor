import 'package:flutter/material.dart';

showSnack(context, String title, Color bgColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bgColor,
      content: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold,),),
    ),
  );
}
