import 'package:flutter/material.dart';
import 'package:estichara/services/storageserv.dart';
class Survey {
  final String question;
   String imagePath; 
  final List<String> options;

  Survey({
    required this.question,
    required this.imagePath,
    required this.options,
  });
}


class SurveyList {
  static final StorageService _storageService = StorageService();

  static List<Survey> surveys = [
    Survey(
      question: 'How satisfied are you with our service?',
      imagePath: 'images/covid-19.png',
      options: ['Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied'],
    ),
  ];

  static Future<void> fetchImageURLs() async {
    for (var survey in surveys) {
      survey.imagePath = await _storageService.getImageUrl(survey.imagePath);
    }
  }
}
