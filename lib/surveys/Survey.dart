import 'package:flutter/material.dart';

class Survey {
  final String question;
  String imagePath;
  String imageUrl = '';
  final List<String> options;

  Survey({
    required this.question,
    required this.imagePath,
    required this.options,
  });
}
