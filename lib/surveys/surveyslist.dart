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
      ],
    ),
    Survey(
      question: 'Which features would you like to see in the future?',
      imagePath: 'img/3.png',
      options: ['Improved UI/UX', 'More functionalities', 'Better performance'],
    ),
Survey(
      question: 'How has the COVID-19 pandemic affected the global economy?',
      imagePath: 'img/3.png',
      options: ['Severe recession & unemployment', 'Digitalization & e-commerce boost', 'Government stimulus & policies','Supply chain disruptions & inflation'],
    ),
  ];
}
