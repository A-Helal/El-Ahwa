import 'package:flutter/material.dart';
import 'package:omer_ahmed_mentorship/models/order.dart';
import 'package:omer_ahmed_mentorship/repos/order_repo.dart';
import 'package:omer_ahmed_mentorship/screens/add_order_form.dart';
import 'package:omer_ahmed_mentorship/screens/reports_screen.dart';
import 'package:omer_ahmed_mentorship/service/order_service.dart';
import 'package:omer_ahmed_mentorship/service/report_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final OrderRepo _orderRepository = InMemoryOrderRepo();
  late OrderService _orderService;
  late ReportService _reportService;

  List<Order> pendingOrders = [];
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _orderService = OrderService(_orderRepository);
    _reportService = ReportService(_orderRepository);
    _loadPendingOrders();
  }

  Future<void> _loadPendingOrders() async {
    final orders = await _orderService.getPendingOrders();
    setState(() {
      pendingOrders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart Ahwa Manager'), centerTitle: true),
      body: IndexedStack(
        index: selectedTabIndex,
        children: [
          _buildDashboardTab(),
          _buildAddOrderTab(),
          _buildReportsTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTabIndex,
        onTap: (index) {
          setState(() {
            selectedTabIndex = index;
          });
          if (index == 0) {
            _loadPendingOrders();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Order'),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Reports',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pending Orders (${pendingOrders.length})',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child:
                pendingOrders.isEmpty
                    ? Center(
                      child: Text(
                        'No pending orders',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                    : ListView.builder(
                      itemCount: pendingOrders.length,
                      itemBuilder: (context, index) {
                        final order = pendingOrders[index];
                        return Card(
                          child: ListTile(
                            title: Text(order.customer.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order.drink.getDescription()),
                                if (order.specialPreparation.isNotEmpty)
                                  Text(
                                    'Special: ${order.specialPreparation}',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                Text(
                                  '${order.totalPrice.toStringAsFixed(2)} EGP',
                                ),
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () => _completeOrder(order.id),
                              child: Text('Complete'),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOrderTab() {
    return AddOrderForm(
      onOrderAdded: () {
        _loadPendingOrders();
        setState(() {
          selectedTabIndex = 0;
        });
      },
      orderService: _orderService,
    );
  }

  Widget _buildReportsTab() {
    return ReportsScreen(reportService: _reportService);
  }

  Future<void> _completeOrder(String orderId) async {
    await _orderService.getCompleteOrders(orderId);
    _loadPendingOrders();
  }
}