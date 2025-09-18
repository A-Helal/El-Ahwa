import 'package:omer_ahmed_mentorship/models/order.dart';

abstract class UpdateOrderRepo {
  Future<void> updateOrder(Order order);
}

abstract class OrderRepo {
  Future<void> addOrder(Order order);

  Future<List<Order>> getAllOrders();

  Future<List<Order>> getPendingOrders();

  Future<List<Order>> getCompletedOrders();

  // Future<void> updateOrder(Order order); //مش محتاجها حاليا في الميموري ف هخليها interface تانيه تحت مبدأ interface segregation

  Future<Order?> getOrderById(String id);
}

class InMemoryOrderRepo implements OrderRepo {
  final List<Order> _orders = [];

  @override
  Future<void> addOrder(Order order) async {
    _orders.add(order);
  }

  @override
  Future<List<Order>> getAllOrders() async {
    return List.from(_orders);
  }

  @override
  Future<List<Order>> getPendingOrders() async {
    return _orders
        .where((order) => order.status == OrderStatus.pending)
        .toList();
  }

  @override
  Future<List<Order>> getCompletedOrders() async {
    return _orders
        .where((order) => order.status == OrderStatus.completed)
        .toList();
  }

  @override
  Future<Order?> getOrderById(String id) async {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }
}
