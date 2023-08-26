import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estichara/surveys/surveyslist.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../history/historyvotes.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: SurveyList.surveys.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SurveyDetailsPage(surveyIndex: index),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Survey ${index + 1}',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        SurveyList.surveys[index].question,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SurveyDetailsPage extends StatefulWidget {
  final int surveyIndex;

  SurveyDetailsPage({required this.surveyIndex});

  @override
  _SurveyDetailsPageState createState() => _SurveyDetailsPageState();
}

class _SurveyDetailsPageState extends State<SurveyDetailsPage> {
  String selectedOption = "";
  late VotingHistoryManager _votingHistoryManager;

  @override
  void initState() {
    super.initState();
    _initializeVotingHistoryManager();
  }

  Future<void> _initializeVotingHistoryManager() async {
    _votingHistoryManager = await VotingHistoryManager.create();
  }

  void selectOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  void submitResponse(String surveyId, String selectedOption) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('responses').add({
      'user_id': userId,
      'survey_id': surveyId,
      'selected_option': selectedOption,
    });

    _votingHistoryManager.setVoted(surveyId);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
            StepProgressIndicator(
              totalSteps: 10,
              currentStep: widget.surveyIndex,
              size: 10,
              padding: 0,
              selectedColor: Colors.orange,
              unselectedColor: Colors.black,
              roundedEdges: Radius.circular(10),
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.orange, Colors.deepOrange],
              ),
              unselectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.black],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 0),
              child: Align(
                alignment: Alignment.center,
                child: Image.network(
                  SurveyList.surveys[widget.surveyIndex].imageUrl,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              SurveyList.surveys[widget.surveyIndex].question,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            for (String option
                in SurveyList.surveys[widget.surveyIndex].options)
              GestureDetector(
                onTap: () => selectOption(option),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: selectedOption == option
                        ? Colors.orange
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      "$option",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (selectedOption.isNotEmpty) {
                      if (await _votingHistoryManager?.hasVoted(SurveyList
                              .surveys[widget.surveyIndex].question) ??
                          false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content:
                                Text('You have already voted in this survey.'),
                          ),
                        );
                      } else {
                        submitResponse(
                          SurveyList.surveys[widget.surveyIndex].question,
                          selectedOption,
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select an option.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Vote',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SurveyScreen(),
  ));
}
