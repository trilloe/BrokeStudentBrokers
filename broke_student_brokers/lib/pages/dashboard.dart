import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'somethingWrong.dart';
import 'loading.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return somethingWrong();
          }

          // Application
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Column(
                children: [
                  Container(
                      height: 240,
                      child: AspectRatio(
                        aspectRatio: 2.3,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              color: Color(0xff202020)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, left: 12.0, top: 24, bottom: 12),
                            child: LineChart(bannerData()),
                          ),
                        ),
                      )),
                  Expanded(
                    // height: 400.0,
                    child: HoldingList(),
                  )
                ],
              ),
            );
          }

          //Otherwise while waiting
          return loading();
        });
  }

  LineChartData bannerData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.white,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                if (flSpot.y >= 0) {
                  return LineTooltipItem(
                    '${flSpot.y}',
                    const TextStyle(color: Colors.green),
                  );
                } else {
                  return LineTooltipItem(
                    '${flSpot.y}',
                    const TextStyle(color: Colors.red),
                  );
                }
              }).toList();
            }),
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.white,
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 10,
                  color: Colors.white,
                ),
              ),
            );
          }).toList();
        },
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      extraLinesData: ExtraLinesData(horizontalLines: [
        HorizontalLine(
          y: 0,
          color: Colors.white.withOpacity(0.4),
          strokeWidth: 1,
          dashArray: [10, 3],
        ),
      ]),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d), fontFamily: "Roboto ", fontSize: 13),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '2/10/18';
              case 5:
                return '7/10/18';
              case 8:
                return '10/10/18';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontSize: 13,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case -100:
                return '-100%';
              case 0:
                return '0%';
              case 100:
                return '100%';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 10,
      minY: -100,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 0),
            FlSpot(1, 50),
            FlSpot(2, -30),
            FlSpot(3, 70),
            FlSpot(4, 20),
            FlSpot(5, 90),
            FlSpot(6, 0),
            FlSpot(7, -40),
            FlSpot(8, -20),
            FlSpot(9, 60),
            FlSpot(10, 75),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  // Colors
  List<Color> gradientColors =
      getColors([0, 50, -30, 70, 20, 90, 0, -40, -20, 60, 75]);
}

// class GaugeChart extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;

//   GaugeChart(this.seriesList, {this.animate});

//   /// Creates a [PieChart] with sample data and no transition.
//   factory GaugeChart.withSampleData() {
//     return new GaugeChart(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new charts.PieChart(seriesList,
//         animate: animate,
//         // Configure the width of the pie slices to 30px. The remaining space in
//         // the chart will be left as a hole in the center. Adjust the start
//         // angle and the arc length of the pie so it resembles a gauge.
//         defaultRenderer: new charts.ArcRendererConfig(
//             arcRatio: 0.12, startAngle: 3 / 2 * pi, arcLength: 2 * pi));
//   }

//   /// Create one series with sample hard coded data.
//   static List<charts.Series<GaugeSegment, String>> _createSampleData() {
//     final data = [
//       new GaugeSegment('GOOGL', 90, charts.Color(r: 89, g: 189, b: 204)),
//       new GaugeSegment('FB', 90, charts.Color(r: 74, g: 143, b: 213)),
//       new GaugeSegment('AAPL', 90, charts.Color(r: 255, g: 106, b: 129)),
//       new GaugeSegment('TSLA', 90, charts.Color(r: 235, g: 75, b: 138)),
//     ];

//     return [
//       new charts.Series<GaugeSegment, String>(
//         id: 'Segments',
//         domainFn: (GaugeSegment segment, _) => segment.segment,
//         measureFn: (GaugeSegment segment, _) => segment.size,
//         colorFn: (GaugeSegment segment, _) => segment.color,
//         data: data,
//       )
//     ];
//   }
// }

// /// Sample data type.
// class GaugeSegment {
//   final String segment;
//   final int size;
//   final charts.Color color;

//   GaugeSegment(this.segment, this.size, this.color);
// }

class HoldingList extends StatefulWidget {
  @override
  _HoldingListState createState() => _HoldingListState();
}

class _HoldingListState extends State<HoldingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('testStocks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _listItemBuilder(context, snapshot.data.documents[index]),
            itemExtent: 95,
          );
        },
      ),
    );
  }
}

@override
Widget _listItemBuilder(BuildContext context, DocumentSnapshot document) {
  return Column(
    children: <Widget>[
      // MaterialButton(
      //   height: 0,
      //   minWidth: 0,
      //   elevation: 0,
      //   onPressed: fetchData(),
      // ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 4.0, 6.0),
                child: Text(
                  document['ticker'],
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 12.0),
                child: Text(
                  document['sharecount'].toString() +
                      (document['sharecount'] == 1 ? ' Share' : ' Shares'),
                  style: TextStyle(fontSize: 13.0),
                ),
              ),
            ],
          ),
          // TODO: Add graph
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: AspectRatio(
                      aspectRatio: 4,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(60.0, 4.0, 60.0, 4.0),
                        child: LineChart(mainData()),
                      )))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '\$ ' + document['currentHoldings'].toString(),
                  style: TextStyle(color: Color(0xFF73FC7D)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$ ' + document['initialHoldings'].toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Icon(
                //     Icons.star_border,
                //     size: 35.0,
                //     color: Colors.grey,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      // Divider(
      //   height: 2.0,
      //   color: Colors.grey,
      // )
    ],
  );
}

LineChartData mainData() {
  return LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              if (flSpot.y >= 0) {
                return LineTooltipItem(
                  '${flSpot.y}',
                  const TextStyle(color: Colors.green),
                );
              } else {
                return LineTooltipItem(
                  '${flSpot.y}',
                  const TextStyle(color: Colors.red),
                );
              }
            }).toList();
          }),
      getTouchedSpotIndicator:
          (LineChartBarData barData, List<int> spotIndexes) {
        return spotIndexes.map((index) {
          return TouchedSpotIndicatorData(
            FlLine(
              color: Colors.white,
            ),
            FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                radius: 10,
                color: Colors.white,
              ),
            ),
          );
        }).toList();
      },
      touchCallback: (LineTouchResponse touchResponse) {},
      handleBuiltInTouches: true,
    ),
    gridData: FlGridData(
      show: false,
    ),
    extraLinesData: ExtraLinesData(horizontalLines: [
      HorizontalLine(
        y: 0,
        color: Colors.white.withOpacity(0.4),
        strokeWidth: 1,
        dashArray: [10, 3],
      ),
    ]),
    titlesData: FlTitlesData(
      show: false,
    ),
    borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 10,
    minY: -10,
    maxY: 10,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 0),
          FlSpot(1, 8),
          FlSpot(2, 0),
          FlSpot(3, 7),
          FlSpot(4, 0),
          FlSpot(5, 9),
          FlSpot(6, 6),
          FlSpot(7, -7),
          FlSpot(8, -1),
          FlSpot(9, -9),
          FlSpot(10, 10),
        ],
        isCurved: true,
        colors: getColors([0, 8, 0, 7, 0, 9, 6, -7, -1, -9, 10]),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
          colors: getColors([0, 8, 0, 7, 0, 9, 6, -7, -1, -9, 10]),
        ),
      ),
    ],
  );
}

//   fetchData() {
//     FirebaseFirestore fs = FirebaseFirestore.instance;
//     fs.collection('stocks').snapshots().listen((snapshot) {
//       setState(() {
//         for (var item in snapshot.docs) {
//           stocks = item.data();
//           _open.add(stocks);
//         }
//       });
//     });
//   }
// }

List<Color> getColors(data) {
  List<Color> li = [];
  for (var i = 0; i < data.length; i++) {
    if (data[i] < 0) {
      li.add(Color(0xffb53c3c));
    } else {
      li.add(Color(0xff73FC7D));
    }
  }
  return li;
}

// class Open {
//   Open({this.name, this.numshares, this.price1, this.price2});

//   String name;
//   String numshares;
//   String price1;
//   String price2;
// }

// List _open = [];
