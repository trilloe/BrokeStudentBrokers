import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  // Colors
  List<Color> gradientColors = getColors([0, 8, 0, 7, 0, 9, 6, -7, -1, -9, 10]);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff202020)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(mainData()),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
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
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
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
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case -10:
                return '-10k';
              case 0:
                return '0';
              case 10:
                return '10k';
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
}

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
