import 'package:shared_preferences/shared_preferences.dart';

class VotingHistoryManager {
  final SharedPreferences _prefs;

  VotingHistoryManager._(this._prefs) ;

  static Future<VotingHistoryManager> create() async {
    final prefs = await SharedPreferences.getInstance();
    return VotingHistoryManager._(prefs);
  }

  void setVoted(String surveyId) async {
    _prefs.setBool(surveyId, true);
  }

  bool hasVoted(String surveyId) {
    return _prefs.getBool(surveyId) ?? false;
  }
}
