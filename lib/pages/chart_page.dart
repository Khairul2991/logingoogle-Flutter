import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class ChartPage extends StatefulWidget {
  final String waterMeterId;
  const ChartPage({super.key, required this.waterMeterId});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<ChartSampleData> chartData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchChartData();
  }

  Future<void> _fetchChartData() async {
    setState(() {
      isLoading = true;
    });

    const url = 'https://mpbf561f6ab75495d33b.free.beeceptor.com/data';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          chartData = data.map((item) {
            return ChartSampleData(
              x: item['day'],
              y: (item['usage'] as num).toDouble(),
            );
          }).toList();
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
  } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.waterMeterId)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                    color: Colors.black,
                  ),
                  axisLine: AxisLine(
                    width: 1,
                    color: Colors.black,
                  ),
                  majorTickLines: MajorTickLines(width: 0),
                ),
                primaryYAxis: const NumericAxis(
                  axisLine: AxisLine(
                    width: 1,
                    color: Colors.black,
                  ),
                  majorGridLines: MajorGridLines(width: 0),
                  labelFormat: '{value}',
                  majorTickLines: MajorTickLines(size: 0),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ColumnSeries<ChartSampleData, String>>[
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
            ),
          ],
        ),
      ),
    );
  }
}

class ChartSampleData {
  final String x;
  final double y;
  ChartSampleData({required this.x, required this.y});
}
