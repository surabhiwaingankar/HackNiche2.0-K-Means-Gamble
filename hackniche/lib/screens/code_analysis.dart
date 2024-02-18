import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:hackniche/global/globalvariables.dart';

class CodeAnalysisDashboard extends StatefulWidget {
  const CodeAnalysisDashboard({Key? key}) : super(key: key);

  @override
  State<CodeAnalysisDashboard> createState() => _CodeAnalysisDashboardState();
}

class _CodeAnalysisDashboardState extends State<CodeAnalysisDashboard> {
  TextEditingController _codeController = TextEditingController();
  List<FlSpot> dummyData1 = [];
  List<FlSpot> dummyData2 = [];
  List<FlSpot> dummyData3 = [];

 
  List colors =[Colors.amber,Colors.green,Colors.orange,Colors.purple,Colors.white];

  dynamic bugDetection;
  dynamic codeDuplication;
  dynamic codeSmell;
  dynamic defects;
  dynamic spaceComplexity;
  dynamic timeComplexity;
  dynamic improve;
  bool isLoading = true;
  bool isClicked =false;

  @override
  void initState() {
    super.initState();
    _generateDummyData();
  }

  void _generateDummyData() {
    dummyData1 = List.generate(8, (index) {
      return FlSpot(index.toDouble(), index * Random().nextDouble());
    });

    dummyData2 = List.generate(8, (index) {
      return FlSpot(index.toDouble(), index * Random().nextDouble());
    });

    dummyData3 = List.generate(8, (index) {
      return FlSpot(index.toDouble(), index * Random().nextDouble());
    });
  }

  Future<void> _getData(String codeData) async {
    try {
      const url = '${GlobalVariables.url}/analyze/code';

      Map<String, dynamic> data = {"input": codeData};
      var encodedData = jsonEncode(data);

      // setState(() {
      //   isLoading = true;
      // });

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: encodedData,
      );

      print('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedData = jsonDecode(response.body);
        bugDetection =double.parse(decodedData['bug_detection'])==null?1.0:double.parse(decodedData['bug_detection']) ;
        codeDuplication =double.parse(decodedData['code_duplication'])==null?1.0:double.parse(decodedData['code_duplication']) ;
        codeSmell =double.parse(decodedData['code_smell'])==null?1.0:double.parse(decodedData['code_smell']) ;
        defects = double.parse(decodedData['defects'])==null?1.0:double.parse(decodedData['defects']); 
        spaceComplexity =double.parse(decodedData['space_complexity']) ;
        timeComplexity = double.parse(decodedData['time_complexity']);
        improve = double.parse(decodedData['ways_to_improve'])==null?'The code is optimmal':double.parse(decodedData['ways_to_improve']);

        print('Response data: $decodedData');
      } else {
        print('Failed to get response. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during data fetching: $e');
    } finally {
      setState(() {
        isLoading = false;
        isClicked=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/CosmicHero.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Code Input
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _codeController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _getData(_codeController.text.toString());
                        },
                        icon: Icon(Icons.send),
                      ),
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
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child:isLoading
                                ? Container(

                                )
                                : PieChart(
                          PieChartData(
                            centerSpaceRadius: 2,
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 2,
                            sections: [
                              PieChartSectionData(
                                value:   codeSmell??1.0,
                                color: Colors.purple,
                                radius: 150,
                              ),
                              PieChartSectionData(
                                value: codeDuplication??1.0,
                                color: Colors.amber,
                                radius: 150,
                              ),
                              PieChartSectionData(
                                value: bugDetection??1.0,
                                color: Colors.green,
                                radius: 150,
                              ),
                              PieChartSectionData(
                                value: defects??1.0,
                                color: Colors.orange,
                                radius: 150,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      // Line Chart
                      Expanded(
                        child: isLoading
                                ? Container(
                                  
                                )
                                :Container(
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
                                  spots: dummyData2,
                                  isCurved: true,
                                  barWidth: 3,
                                  color: Colors.red,
                                ),
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
                      Expanded(
                        child: isLoading
                                ? Container(
                                  
                                )
                                :Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: isLoading
                                ? Container(
                                  
                                )
                                : Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        
                                        ListTile(trailing: Icon(Icons.circle_rounded,color: colors[0],),title:Text("code_smell:${codeSmell}",style:TextStyle(color: Colors.white))),
                                        ListTile(trailing: Icon(Icons.circle_rounded,color: colors[3],),title:Text("code_duplication:${codeDuplication}",style:TextStyle(color: Colors.white))),
                                        ListTile(trailing: Icon(Icons.circle_rounded,color: colors[1],),title:Text("bug_detection:${bugDetection}",style:TextStyle(color: Colors.white))),
                                        ListTile(trailing: Icon(Icons.circle_rounded,color: colors[2],),title:Text("defects:${defects}",style:TextStyle(color: Colors.white))),
                                        ListTile(trailing: Icon(Icons.circle_rounded,color: colors[4],),title:Text("time_complexity:${timeComplexity}",style:TextStyle(color: Colors.white))),
                                        ListTile(trailing: Icon(Icons.circle_rounded,color: colors[4],),title:Text("space_complexity:${spaceComplexity}",style:TextStyle(color: Colors.white))),






                                      ],
                                    ),
                                  ),
                                )
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(13, 13, 13, 1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          child: isLoading
                                ? Container(
                                  
                                )
                                : Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "ways to improve: $improve",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
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
    );
  }
}