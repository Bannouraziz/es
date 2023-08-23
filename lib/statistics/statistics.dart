import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:estichara/statistics/statisticsservices.dart';
import 'dart:math';

class AllSurveysStatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, Map<String, int>>>(
        future: AllSurveysStatisticsService().getAllSurveysStatistics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading statistics'));
          } else if (snapshot.hasData) {
            Map<String, Map<String, int>> allStatistics = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: allStatistics.keys.map((surveyId) {
                    Map<String, int> statistics = allStatistics[surveyId]!;
                    List<ChartData> chartData = [];

                    int totalResponses =
                        statistics.values.fold(0, (sum, value) => sum + value);

                    Map<String, double> optionsMap = {};

                    statistics.keys.forEach((option) {
                      optionsMap[option] = 0.0;
                    });

                    statistics.forEach((option, count) {
                      double percentage = (count / totalResponses) * 100;
                      optionsMap[option] = percentage;
                    });

                    optionsMap.forEach((option, percentage) {
                      chartData.add(ChartData(option, percentage));
                    });

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Survey: $surveyId',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 350,
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12,
                                  ),
                                ),
                                primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12,
                                  ),
                                  axisLine: const AxisLine(width: 0),
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
                                    xValueMapper: (ChartData data, _) =>
                                        data.option,
                                    yValueMapper: (ChartData data, _) =>
                                        data.percentage,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      labelAlignment:
                                          ChartDataLabelAlignment.top,
                                      textStyle: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    color: Color.fromRGBO(255, 165, 0, 1),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
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
