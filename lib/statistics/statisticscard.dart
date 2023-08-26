import 'package:flutter/material.dart';
import 'package:estichara/statistics/statisticsservices.dart';
import 'package:estichara/statistics/statistics.dart';
import '../surveys/surveyslist.dart';

class SurveyListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: SurveyList.surveys.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SurveyStatisticsScreen(survey: SurveyList.surveys[index]),
                ),
              );
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  title: Text(
                    SurveyList.surveys[index].question,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
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
