import 'package:cognizant_assessment/model/ProspectStatus.dart';
import 'package:flutter/material.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';

class CircularChartRoute extends StatefulWidget {
  const CircularChartRoute({Key? key}) : super(key: key);

  @override
  _CircularChart createState() => _CircularChart();
}

class _CircularChart extends State<CircularChartRoute> {
  final _hot = ProspectStatus('Hot', 35, '25%');
  final _warm = ProspectStatus('Warm', 35, '25%');
  final _cold = ProspectStatus('Cold', 90, '50%');

  final MaterialAccentColor _hotColor = Colors.redAccent;
  final MaterialAccentColor _warmColor = Colors.orangeAccent;
  final MaterialAccentColor _coldColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _createCircularPieChart(),
    );
  }

  Widget _createCircularPieChart() {
    return Container(
      color: const Color(0xFFEFEBE9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: 270,
            width: double.infinity,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Prospect by Status',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      )),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 50,
                            child: Container(
                              margin: const EdgeInsets.only(left: 16),
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
                              ),
                            )),
                        Expanded(
                            flex: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: _colorTextColumn(),
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
                _hot.count,
                _hotColor,
                rankKey: _hot.type,
              ),
              CircularSegmentEntry(
                _warm.count,
                _warmColor,
                rankKey: _warm.type,
              ),
              CircularSegmentEntry(
                _cold.count,
                _coldColor,
                rankKey: _cold.type,
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
        colorCircleShape(_hot, _hotColor),
        colorCircleShape(_warm, _warmColor),
        colorCircleShape(_cold, _coldColor)
      ],
    );
  }

  Widget colorCircleShape(ProspectStatus status, MaterialAccentColor color) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color // Color of the circular shape
                  ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 5),
                width: 50,
                height: 40,
                child: Text(status.type,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black87)))
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("${status.count.floor()}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87)),
              const SizedBox(width: 10),
              Text(status.percentage,
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xFF607D8B))),
              const SizedBox(width: 16)
            ],
          ),
        ),
      ],
    );
  }
}
