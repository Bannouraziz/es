import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estichara/surveys/surveyslist.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surveys'),
      ),
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
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SurveyList.surveys[widget.surveyIndex].question,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            for (int i = 0;
                i < SurveyList.surveys[widget.surveyIndex].options.length;
                i++)
              ListTile(
                title: Text(SurveyList.surveys[widget.surveyIndex].options[i]),
                leading: Radio<String>(
                  value: SurveyList.surveys[widget.surveyIndex].options[i],
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedOption != null) {
                  // Save the user's vote here
                  Navigator.pop(context);
                } else {
                  // Show an error message if no option is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select an option.'),
                    ),
                  );
                }
              },
              child: Text('Vote'),
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
