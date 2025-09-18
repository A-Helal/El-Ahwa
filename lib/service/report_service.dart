import 'package:omer_ahmed_mentorship/repos/order_repo.dart';

class DailySalesReport {
  final DateTime date;
  final int totalOrders;
  final double totalRevenue;
  final Map<String, int> topSellingDrinks;
  final Map<String, double> revenueByDrink;

  DailySalesReport({
    required this.date,
    required this.totalOrders,
    required this.totalRevenue,
    required this.topSellingDrinks,
    required this.revenueByDrink,
  });
}

class ReportService {
  final OrderRepo _repository;

  ReportService(this._repository);

  Future<DailySalesReport> generateDailyReport([DateTime? date]) async {
    final reportDate = date ?? DateTime.now();
    final allOrders = await _repository.getCompletedOrders();
    final dailyOrders =
        allOrders.where((order) {
          return order.createdAt.year == reportDate.year &&
              order.createdAt.month == reportDate.month &&
              order.createdAt.day == reportDate.day;
        }).toList();
    final totalOrders = dailyOrders.length;
    final totalRevenue = dailyOrders.fold<double>(
      0.0,
      (sum, order) => sum + order.totalPrice,
    );
    final drinkCounts = <String, int>{};
    final drinkRevenue = <String, double>{};
    for (final order in dailyOrders) {
      final drinkName = order.drink.name;
      drinkCounts[drinkName] = (drinkCounts[drinkName] ?? 0) + 1;
      drinkRevenue[drinkName] =
          (drinkRevenue[drinkName] ?? 0) + order.totalPrice;
    }
    return DailySalesReport(
      date: reportDate,
      totalOrders: totalOrders,
      totalRevenue: totalRevenue,
      topSellingDrinks: drinkCounts,
      revenueByDrink: drinkRevenue,
    );
  }

  Future<Map<String, int>> getTopSellingDrinks({int limit = 5}) async {
    final allOrders = await _repository.getCompletedOrders();
    final drinkCounts = <String, int>{};

    for (final order in allOrders) {
      final drinkName = order.drink.name;
      drinkCounts[drinkName] = (drinkCounts[drinkName] ?? 0) + 1;
    }
    final sortedEntries =
        drinkCounts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    final topEntries = sortedEntries.take(limit);
    return Map.fromEntries(topEntries);
  }
}
