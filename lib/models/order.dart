import 'package:omer_ahmed_mentorship/models/customer.dart';
import 'package:omer_ahmed_mentorship/models/drinks_model.dart';

enum OrderStatus { pending, completed, cancelled }

class Order {
  final String _id;
  final Customer _customer;
  final Drinks _drinks;
  final String _specialPreparation;
  final DateTime _createAt;
  OrderStatus _status;

  Order({
    required String id,
    required Customer customer,
    required Drinks drinks,
    String specialPreparation = '',
  }) : _id = id,
       _customer = customer,
       _drinks = drinks,
       _specialPreparation = specialPreparation,
       _createAt = DateTime.now(),
       _status = OrderStatus.pending;

  String get id => _id;

  Customer get customer => _customer;

  Drinks get drink => _drinks;

  String get specialPreparation => _specialPreparation;

  DateTime get createdAt => _createAt;

  OrderStatus get status => _status;

  void markedAsCompleted() {
    _status = OrderStatus.completed;
  }

  void markedAsCancelled() {
    _status = OrderStatus.cancelled;
  }

  double get totalPrice => _drinks.calculatePrice();

  @override
  String toString() {
    return "${_customer.name}'s Order is: ${_drinks.getDescription()}";
  }
}
