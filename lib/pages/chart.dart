import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  final String waterMeterId;
  const ChartPage({super.key, required this.waterMeterId});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<ChartSampleData> chartData = [];

  @override
  void initState() {
    super.initState();
    _loadDummyData();
  }

  void _loadDummyData() {
    chartData = [
      ChartSampleData(x: 'Mon', y: 2.5),
      ChartSampleData(x: 'Tue', y: 1.8),
      ChartSampleData(x: 'Wed', y: 3.2),
      ChartSampleData(x: 'Thu', y: 2.9),
      ChartSampleData(x: 'Fri', y: 1.4),
      ChartSampleData(x: 'Sat', y: 2.2),
      ChartSampleData(x: 'Sun', y: 1.9),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.waterMeterId)),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1 August - 7 August',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Total usage this week:',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '${chartData.fold(0.0, (sum, data) => sum + data.y)} m³',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  margin: EdgeInsets.zero,
                  primaryXAxis: const CategoryAxis(
                    majorGridLines: MajorGridLines(
                      width: 1,
                      color: Colors.black, // Set black color for gridlines
                    ),
                    axisLine: AxisLine(
                      width: 1,
                      color: Colors.black, // Set black color for axis line
                    ),
                    majorTickLines: MajorTickLines(width: 0),
                  ),
                  primaryYAxis: const NumericAxis(
                      axisLine: AxisLine(
                        width: 1,
                        color: Colors.black, // Set black color for axis line
                      ),
                      majorGridLines: MajorGridLines(width: 0),
                      labelFormat: '{value}',
                      majorTickLines: MajorTickLines(size: 0)
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ColumnSeries>[
                    ColumnSeries<ChartSampleData, String>(
                      dataSource: chartData,
                      isTrackVisible: true,
                      trackColor: const Color(0xFFC0C0C0),
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.y,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(50),
                        bottom: Radius.circular(25),
                      ),
                      spacing: 0.1,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}

class ChartSampleData {
  final String x;
  final double y;
  ChartSampleData({required this.x, required this.y});
}

