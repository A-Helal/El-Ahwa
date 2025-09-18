import 'package:omer_ahmed_mentorship/models/customer.dart';
import 'package:omer_ahmed_mentorship/models/drinks_model.dart';
import 'package:omer_ahmed_mentorship/models/order.dart';
import 'package:omer_ahmed_mentorship/repos/order_repo.dart';

class OrderService {
  final OrderRepo _repo;

  OrderService(this._repo);

  Future<void> createOrder({
    required String customerName,
    required Drinks drink,
    String specialPreparation = '',
  }) async {
    final customer = Customer(customerName);
    final order = Order(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      customer: customer,
      drinks: drink,
      specialPreparation: specialPreparation,
    );
    await _repo.addOrder(order);
  }

  Future<List<Order>> getPendingOrders() async {
    return await _repo.getPendingOrders();
  }

  Future<void> getCompleteOrders(String orderId) async {
    final order = await _repo.getOrderById(orderId);
    if (order != null) {
      order.markedAsCompleted();
    }
  }

  Future<List<Order>> getAllOrders() async {
    return await _repo.getAllOrders();
  }
}
