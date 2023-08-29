import 'package:Estichara/services/storageserv.dart';
import 'package:Estichara/surveys/Survey.dart';
import 'package:Estichara/services/firestoreserv.dart';

class SurveyList {
  static final StorageService _storageService = StorageService();
  final FirestoreService _firestoreService = FirestoreService();

  static List<Survey> surveys = [];

  Future<void> fetchSurveysAndImageURLs() async {
    List<Survey> fetchedSurveys = await _firestoreService.getSurveys();

    for (var survey in fetchedSurveys) {
      survey.imageUrl = await _storageService.getImageUrl(survey.imagePath);
    }

    surveys = fetchedSurveys;
  }
}
