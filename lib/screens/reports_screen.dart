import 'package:flutter/material.dart';
import 'package:omer_ahmed_mentorship/service/report_service.dart';

class ReportsScreen extends StatefulWidget {
  final ReportService reportService;

  const ReportsScreen({super.key, required this.reportService});

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DailySalesReport? dailyReport;
  Map<String, int> topSellingDrinks = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() {
      isLoading = true;
    });

    try {
      final report = await widget.reportService.generateDailyReport();
      final topDrinks = await widget.reportService.getTopSellingDrinks();

      setState(() {
        dailyReport = report;
        topSellingDrinks = topDrinks;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading reports: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Sales Report',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: _loadReports,
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            SizedBox(height: 20),

            if (dailyReport != null) ...[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Summary',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Orders:', style: TextStyle(fontSize: 16)),
                          Text(
                            '${dailyReport!.totalOrders}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Revenue:', style: TextStyle(fontSize: 16)),
                          Text(
                            '${dailyReport!.totalRevenue.toStringAsFixed(2)} EGP',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Top Selling Drinks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              if (topSellingDrinks.isEmpty)
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No sales data available yet'),
                  ),
                )
              else
                ...topSellingDrinks.entries.map((entry) {
                  return Card(
                    child: ListTile(
                      title: Text(entry.key),
                      trailing: Text(
                        '${entry.value} orders',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
            ] else
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No report data available'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}