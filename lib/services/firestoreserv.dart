import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estichara/services/storageserv.dart'; // Import the StorageService
import 'package:estichara/surveys/surveyslist.dart';
import 'package:estichara/surveys/Survey.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();

  Future<List<Survey>> getSurveys() async {
    QuerySnapshot surveySnapshot = await _firestore.collection('collection1').get();

    List<Survey> surveys = [];

    for (QueryDocumentSnapshot surveyDoc in surveySnapshot.docs) {
      Survey survey1 = Survey(
        question: surveyDoc['question1'] ?? '',
        imagePath: surveyDoc['imagePath1'] ?? '',
        options: List<String>.from(surveyDoc['options1'] ?? []),
      );
     

      survey1.imageUrl = await _storageService.getImageUrl(survey1.imagePath);
      surveys.add(survey1);
   
    }

    return surveys;
  }
}
