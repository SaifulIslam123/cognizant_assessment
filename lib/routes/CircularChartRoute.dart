import 'package:flutter/material.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CircularChart createState() => _CircularChart();
}
class _CircularChart extends State<MyHomePage> {
  final String _hot = 'Hot';
  final String _warm = 'Warm';
  final String _cold = 'Cold ';

  final MaterialAccentColor _hotColor = Colors.redAccent;
  final MaterialAccentColor _warmColor = Colors.orangeAccent;
  final MaterialAccentColor _coldColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFEFEBE9),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: 270,
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Prospect by Status',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      )),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 50,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: _circularPieChart(),
                                ),
                                const Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '160',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87),
                                        ),
                                        Text('Total Prospects',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF607D8B)))
                                      ],
                                    ))
                              ],
                            )),
                        Expanded(
                            flex: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [_colorTextColumn()],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _circularPieChart() {
    final GlobalKey<AnimatedCircularChartState> _chartKey =
        GlobalKey<AnimatedCircularChartState>();
    return AnimatedCircularChart(
        key: _chartKey,
        size: const Size(200, 200),
        initialChartData: <CircularStackEntry>[
          CircularStackEntry(
            <CircularSegmentEntry>[
              CircularSegmentEntry(
                35,
                _hotColor,
                rankKey: _hot,
              ),
              CircularSegmentEntry(
                35,
                _warmColor,
                rankKey: _warm,
              ),
              CircularSegmentEntry(
                90,
                _coldColor,
                rankKey: _cold,
              ),
            ],
            rankKey: 'progress',
          ),
        ],
        chartType: CircularChartType.Radial,
        percentageValues: false);
  }

  Widget _colorTextColumn() {
    return Column(
      children: [
        Row(
          children: [colorCircleShape(_hot, _hotColor)],
        ),
        colorCircleShape(_warm, _warmColor),
        colorCircleShape(_cold, _coldColor)
      ],
    );
  }

  Widget colorCircleShape(String type, MaterialAccentColor color) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color // Color of the circular shape
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
                alignment: Alignment.centerLeft,
                width: 60,
                height: 40,
                child: Text(type,
                    style: const TextStyle(fontSize: 16, color: Colors.black87)))
          ],
        ),
      ],
    );
  }
}
