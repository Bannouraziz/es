import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Estichara/statistics/statistics.dart';
import '../surveys/surveyslist.dart';

class SurveyListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          bool canViewStatistics =
              snapshot.data!.get('check_stat') ?? false;

          return ListView.builder(
            itemCount: SurveyList.surveys.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (canViewStatistics) {
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
                          child: Text('Statistics are not available yet!'),
                        ),
                      ),
                    );
                  }
                },
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
                        color: canViewStatistics
                            ? Colors.orange
                            : Colors.grey,
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
