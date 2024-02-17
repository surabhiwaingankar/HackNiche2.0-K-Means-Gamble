import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CodeAnalysisDashboard extends StatefulWidget {
  const CodeAnalysisDashboard({Key? key}) : super(key: key);

  @override
  State<CodeAnalysisDashboard> createState() => _CodeAnalysisDashboardState();
}

class _CodeAnalysisDashboardState extends State<CodeAnalysisDashboard> {
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  getdata()async{

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/CosmicHero.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            // Sidebar

            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Code Input
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Color.fromRGBO(26, 26, 26, 1),
                        filled: true,
                        prefixIcon: Icon(Icons.menu),
                        hintText: "Enter the Code",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Charts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Pie Chart
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(13, 13, 13, 1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          child: PieChart(
                            PieChartData(
                              centerSpaceRadius: 5,
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 2,
                              sections: [
                                PieChartSectionData(
                                    value: 35, color: Colors.purple, radius: 100),
                                PieChartSectionData(
                                    value: 40, color: Colors.amber, radius: 100),
                                PieChartSectionData(
                                    value: 55, color: Colors.green, radius: 100),
                                PieChartSectionData(
                                    value: 70, color: Colors.orange, radius: 100),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // Line Chart
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(13, 13, 13, 1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: LineChart(
                              LineChartData(
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: dummyData1,
                                    isCurved: true,
                                    barWidth: 3,
                                    color: Colors.indigo,
                                  ),
                                  LineChartBarData(
                                    spots: dummyData2,
                                    isCurved: true,
                                    barWidth: 3,
                                    color: Colors.red,
                                  ),
                                  LineChartBarData(
                                    spots: dummyData3,
                                    isCurved: false,
                                    barWidth: 3,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Placeholder
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(13, 13, 13, 1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(13, 13, 13, 1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
