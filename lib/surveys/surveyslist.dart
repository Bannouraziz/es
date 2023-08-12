import 'package:flutter/material.dart';

class Survey {
  final String question;
  final String imagePath;
  final List<String> options;

  Survey({
    required this.question,
    required this.imagePath,
    required this.options,
  });
}

class SurveyList {
  static List<Survey> surveys = [
    Survey(
      question: 'How satisfied are you with our service?',
      imagePath: 'img/1.png',
      options: [
        'Very Satisfied',
        'Satisfied',
        'Neutral',
        'Dissatisfied',
        'Very Dissatisfied'
      ],
    ),
    Survey(
      question: 'Which features would you like to see in the future?',
      imagePath: 'https://via.placeholder.com/163x163',
      options: ['Improved UI/UX', 'More functionalities', 'Better performance'],
    ),
    // Add more survey data here...
  ];
}
