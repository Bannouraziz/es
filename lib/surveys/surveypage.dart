import 'package:flutter/material.dart';
import 'package:Estichara/surveys/surveyslist.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  List<Map<String, dynamic>> _userResponses = [];

  void _saveResponse(int questionIndex, String selectedOption) {
    setState(() {
      _userResponses
          .add({'questionIndex': questionIndex, 'response': selectedOption});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Survey'),
      ),
      body: Center(
        child: Container(
          width: 414,
          height: 896,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Stack(
            children: [
              for (int i = 0; i < SurveyList.surveys.length; i++)
                Positioned(
                  left: 114,
                  top: 131 + i * 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 163,
                        height: 163,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage(SurveyList.surveys[i].imagePath),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Question ${i + 1}/${SurveyList.surveys.length}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.60,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        SurveyList.surveys[i].question,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.48,
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: SurveyList.surveys[i].options
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          String option = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  '${index + 1}.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.28,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  option,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.28,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
