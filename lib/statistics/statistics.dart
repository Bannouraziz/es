import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:estichara/statistics/statisticsservices.dart';
import 'package:estichara/surveys/Survey.dart';

class SurveyStatisticsScreen extends StatefulWidget {
  final Survey survey;

  SurveyStatisticsScreen({required this.survey});

  @override
  _SurveyStatisticsScreenState createState() => _SurveyStatisticsScreenState();
}

class _SurveyStatisticsScreenState extends State<SurveyStatisticsScreen> {
  Future<Map<String, int>>? _statisticsFuture;

  @override
  void initState() {
    super.initState();
    _statisticsFuture =
        SurveyStatisticsService().getSurveyStatistics(widget.survey.question);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, int>>(
        future: _statisticsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading statistics'));
          } else if (snapshot.hasData) {
            Map<String, int> statistics = snapshot.data!;
            List<ChartData> chartData = [];

            int totalResponses =
                statistics.values.fold(0, (sum, value) => sum + value);

            statistics.forEach((option, count) {
              double percentage = (count / totalResponses) * 100;
              chartData.add(ChartData(option, percentage));
            });

            double screenHeight = MediaQuery.of(context).size.height;
            double topPadding = screenHeight * 0.08;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: topPadding),
                    child: Text(
                      'Survey: ${widget.survey.question}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: 100,
                            labelFormat: '{value}%',
                          ),
                          plotAreaBorderWidth: 0,
                          backgroundColor: Colors.white,
                          series: <ColumnSeries<ChartData, String>>[
                            ColumnSeries<ChartData, String>(
                              isTrackVisible: true,
                              trackColor:
                                  const Color.fromRGBO(198, 201, 207, 1),
                              borderRadius: BorderRadius.circular(15),
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.option,
                              yValueMapper: (ChartData data, _) => double.parse(
                                  data.percentage.toStringAsFixed(2)),
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                              color: Color.fromRGBO(255, 165, 0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No statistics available'));
          }
        },
      ),
    );
  }
}

class ChartData {
  final String option;
  final double percentage;

  ChartData(this.option, this.percentage);
}
