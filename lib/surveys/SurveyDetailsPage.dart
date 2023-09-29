import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Estichara/surveys/surveyslist.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Estichara/history/historyvotes.dart';
import 'package:Estichara/admob/admobservices.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

int AdNumber = 1;

class SurveyDetailsPage extends StatefulWidget {
  final int surveyIndex;
  final Function(int) markAsVoted;
  SurveyDetailsPage({required this.surveyIndex, required this.markAsVoted});

  @override
  _SurveyDetailsPageState createState() => _SurveyDetailsPageState();
}

class _SurveyDetailsPageState extends State<SurveyDetailsPage> {
  String selectedOption = "";
  bool showConfirmation = false;
  InterstitialAd? _interstitialAd;
  bool adDisplayed = false;

  late VotingHistoryManager _votingHistoryManager;

  @override
  void initState() {
    super.initState();
    _initializeVotingHistoryManager();
    loadInterstitialAd();
  }

  Future<void> _initializeVotingHistoryManager() async {
    _votingHistoryManager = await VotingHistoryManager.create();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.InterAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print('Ad loaded.');
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('Ad failed to load: $error');
        },
      ),
    );
  }

  void disposeInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }

  void selectOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  Future<bool> checkVotingHistory(String surveyId, String userId) async {
    return _votingHistoryManager.hasVoted(surveyId, userId);
  }

  void submitResponse(String surveyId, String selectedOption) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    bool hasVoted = await checkVotingHistory(
        SurveyList.surveys[widget.surveyIndex].question, userId);

    if (!hasVoted) {
      await Future.delayed(Duration(seconds: 1));
      await FirebaseFirestore.instance.collection('responses').add({
        'user_id': userId,
        'survey_id': surveyId,
        'selected_option': selectedOption,
      });

      await _votingHistoryManager.setVoted(surveyId, userId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Center(child: Text('Thank you for voting !')),
        ),
      );

      if ((mounted && _interstitialAd != null) &&
          (AdNumber == 1 || AdNumber == 5 || AdNumber == 10)) {
        await _interstitialAd!.show();
      }
      AdNumber++;

      widget.markAsVoted(widget.surveyIndex);

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('You have already voted for this survey.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    disposeInterstitialAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
            StepProgressIndicator(
              totalSteps: 9,
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
            SizedBox(height: 35),
            Container(
              margin: EdgeInsets.only(left: 0),
              child: Align(
                alignment: Alignment.center,
                child: FadeInImage(
                  placeholder: AssetImage('img/6.png'),
                  image: NetworkImage(
                      SurveyList.surveys[widget.surveyIndex].imageUrl),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text(
                        'Image could not loaded',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 35),
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
                  padding: EdgeInsets.all(9),
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
                      setState(() {
                        showConfirmation = true;
                      });

                      submitResponse(
                        SurveyList.surveys[widget.surveyIndex].question,
                        selectedOption,
                      );

                      if (mounted) {
                        setState(() {
                          showConfirmation = false;
                        });
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
