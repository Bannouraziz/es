import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Estichara/services/storageserv.dart';
import 'package:Estichara/surveys/Survey.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();

  Future<List<Survey>> getSurveys() async {
    QuerySnapshot surveySnapshot = await _firestore.collection('collection1').get();

    List<Survey> surveys = [];

    for (QueryDocumentSnapshot surveyDoc in surveySnapshot.docs) {
      Survey survey1 = Survey(
        question: surveyDoc['question'] ?? '',
        imagePath: surveyDoc['imagePath'] ?? '',
        options: List<String>.from(surveyDoc['options'] ?? []),
      );
     

      survey1.imageUrl = await _storageService.getImageUrl(survey1.imagePath);
      surveys.add(survey1);
   
    }

    return surveys;
  }
}
class SurveyResponseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveSurveyResponse(String userId, String surveyId, String selectedOption) async {
    await _firestore.collection('responses').add({
      'user_id': userId,
      'survey_id': surveyId,
      'selected_option': selectedOption.toString(),
    });
  }
}

