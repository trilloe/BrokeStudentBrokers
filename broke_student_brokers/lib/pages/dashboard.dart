import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(height: 250, child: GaugeChart.withSampleData()),
          Expanded(
            // height: 400.0,
            child: HoldingList(),
          )
        ],
      ),
    );
  }
}

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GaugeChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData() {
    return new GaugeChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 30px. The remaining space in
        // the chart will be left as a hole in the center. Adjust the start
        // angle and the arc length of the pie so it resembles a gauge.
        defaultRenderer: new charts.ArcRendererConfig(
            arcRatio: 0.12, startAngle: 3 / 2 * pi, arcLength: 2 * pi));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      new GaugeSegment('GOOGL', 90, charts.Color(r: 89, g: 189, b: 204)),
      new GaugeSegment('FB', 90, charts.Color(r: 74, g: 143, b: 213)),
      new GaugeSegment('AAPL', 90, charts.Color(r: 255, g: 106, b: 129)),
      new GaugeSegment('TSLA', 90, charts.Color(r: 235, g: 75, b: 138)),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}

class HoldingList extends StatelessWidget {
  final List ticker = [
    'TSLA',
    'TSLA',
    'TSLA',
    'TSLA',
    'TSLA',
    'TSLA',
    'TSLA',
    'TSLA',
    'TSLA',
    'TSLA',
    'TSLA',
  ];
  final List share_count = [
    1,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, position) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 4.0, 6.0),
                        child: Text(
                          ticker[position],
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 12.0),
                        child: Text(
                          share_count[position].toString() +
                              (share_count[position] == 1
                                  ? ' Share'
                                  : ' Shares'),
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                  // TODO: Add graph
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Text('add graph here')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "\$219.03",
                          style: TextStyle(color: Color(0xFF73FC7D)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "(\$215.65)",
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
        },
        itemCount: ticker.length,
      ),
    );
  }
}
