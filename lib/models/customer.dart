class Customer {
  final String _name;
  final String _phoneNumber;

  Customer(this._name, [this._phoneNumber = '']);

  String get name => _name;

  String get phoneNumber => _phoneNumber;

  bool get hasPhoneNumber => _phoneNumber.isNotEmpty;

  @override
  String toString() => _name;
}
