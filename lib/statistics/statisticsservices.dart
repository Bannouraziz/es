import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Estichara/surveys/surveyslist.dart';
import 'package:Estichara/surveys/Survey.dart';

class SurveyStatisticsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalResponses = 0;

  Future<Map<String, int>> getSurveyStatistics(String surveyId) async {
    QuerySnapshot responseSnapshot = await _firestore
        .collection('responses')
        .where('survey_id', isEqualTo: surveyId)
        .get();

    Map<String, int> statistics = {};
    Survey survey =
        SurveyList.surveys.firstWhere((survey) => survey.question == surveyId);

    for (QueryDocumentSnapshot responseDoc in responseSnapshot.docs) {
      String selectedOption = responseDoc['selected_option'] as String;

      totalResponses++;

      statistics[selectedOption] = (statistics[selectedOption] ?? 0) + 1;
    }

    for (String option in statistics.keys) {
      double percentage = (statistics[option]! / totalResponses) * 100;
      statistics[option] = percentage.toInt();
    }

    return statistics;
  }
}

class AllSurveysStatisticsService {
  final SurveyStatisticsService _surveyStatisticsService =
      SurveyStatisticsService();

  Future<Map<String, Map<String, int>>> getAllSurveysStatistics() async {
    Map<String, Map<String, int>> allStatistics = {};

    for (Survey survey in SurveyList.surveys) {
      String surveyId = survey.question;
      Map<String, int> statistics =
          await _surveyStatisticsService.getSurveyStatistics(surveyId);
      allStatistics[surveyId] = statistics;
    }

    return allStatistics;
  }
}
