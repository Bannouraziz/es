import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Estichara/statistics/statistics.dart';
import '../surveys/surveyslist.dart';
import 'package:Estichara/admob/admobservices.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

int AdNumber = 1;

class SurveyListScreen extends StatefulWidget {
  @override
  State<SurveyListScreen> createState() => _SurveyListScreenState();
}

class _SurveyListScreenState extends State<SurveyListScreen> {
  InterstitialAd? _interstitialAd;

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

  void initState() {
    super.initState();
    loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('can_survey')
            .doc('can_vote')
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Document not found or empty'));
          }

          bool canViewStatistics = snapshot.data!.get('check_stat') ?? false;

          return ListView.builder(
            itemCount: SurveyList.surveys.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  if (canViewStatistics) {
                    if ((_interstitialAd != null) &&
                        (AdNumber == 1 || AdNumber == 10 || AdNumber == 5)) {
                      await _interstitialAd!.show();
                    }
                    AdNumber++;
                    _interstitialAd!.fullScreenContentCallback =
                        FullScreenContentCallback(
                      onAdDismissedFullScreenContent: (ad) {
                        loadInterstitialAd();
                      },
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurveyStatisticsScreen(
                          survey: SurveyList.surveys[index],
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.orange,
                        content: Center(
                          child: Text(
                              "You'll be notified when the stats are ready!"),
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        title: Text(
                          SurveyList.surveys[index].question,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: Icon(
                          Icons.bar_chart_rounded,
                          color:
                              canViewStatistics ? Colors.orange : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
