import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Estichara/surveys/surveyslist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SurveyDetailsPage.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late List<bool> hasVotedList;

  @override
  void initState() {
    super.initState();
    loadHasVotedList();
  }

  Future<void> loadHasVotedList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> votedSurveyQuestions =
        prefs.getStringList('votedSurveyQuestions') ?? [];
    hasVotedList = List.generate(
      SurveyList.surveys.length,
      (index) =>
          votedSurveyQuestions.contains(SurveyList.surveys[index].question),
    );
  }

  Future<bool> canVote() async {
    DocumentSnapshot canVoteDoc = await FirebaseFirestore.instance
        .collection('can_survey')
        .doc('can_vote')
        .get();
    bool canVote = canVoteDoc.get('voting');
    return canVote;
  }

  Future<void> markSurveyAsVoted(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> votedSurveyQuestions =
        prefs.getStringList('votedSurveyQuestions') ?? [];
    votedSurveyQuestions.add(SurveyList.surveys[index].question);
    await prefs.setStringList('votedSurveyQuestions', votedSurveyQuestions);
    setState(() {
      hasVotedList[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Surveys',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: FutureBuilder<bool>(
        future: canVote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            bool canVote = snapshot.data ?? false;

            return ListView.builder(
              itemCount: SurveyList.surveys.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (!hasVotedList[index]) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SurveyDetailsPage(
                                surveyIndex: index,
                                markAsVoted: markSurveyAsVoted,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.check, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text(
                                      'You have already voted for this survey.'),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: canVote ? Colors.white : Colors.grey[300],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Survey ${index + 1}',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: canVote ? Colors.black : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              SurveyList.surveys[index].question,
                              style: TextStyle(
                                fontSize: 16,
                                color: canVote
                                    ? Colors.grey[700]
                                    : Colors.grey[500],
                              ),
                            ),
                            if (hasVotedList[index])
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.check, color: Colors.green),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
