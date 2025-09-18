import 'package:flutter/material.dart';
import 'package:omer_ahmed_mentorship/factories/drinks_factory.dart';
import 'package:omer_ahmed_mentorship/service/order_service.dart';

class AddOrderForm extends StatefulWidget {
  final VoidCallback onOrderAdded;
  final OrderService orderService;

  const AddOrderForm({
    super.key,
    required this.onOrderAdded,
    required this.orderService,
  });

  @override
  _AddOrderFormState createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _specialInstructionsController = TextEditingController();

  String selectedDrinkType = 'Tea';
  final List<String> drinkTypes = ['Tea', 'Ahwa Torky'];
  final Map<String, DrinksFactory> drinkFactories = {
    'Tea': TeaDrink(),
    'Ahwa Torky': AhwaDrink(),
  };
  bool withMint = false;
  int sugarLevel = 2;
  String coffeePreparation = 'mazbout';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Order',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter customer name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              DropdownButtonFormField(
                value: selectedDrinkType,
                decoration: InputDecoration(
                  labelText: 'Drink Type',
                  border: OutlineInputBorder(),
                ),
                items:
                    drinkTypes.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDrinkType = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),

              _buildDrinkOptions(),
              SizedBox(height: 16),

              TextFormField(
                controller: _specialInstructionsController,
                decoration: InputDecoration(
                  labelText:
                      'Special Instructions (e.g., "extra mint, ya 3me")',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitOrder,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Add Order', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrinkOptions() {
    switch (selectedDrinkType) {
      case 'Tea':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: Text('With Mint'),
              value: withMint,
              onChanged: (bool? value) {
                setState(() {
                  withMint = value ?? false;
                });
              },
            ),
            Text('Sugar Level: $sugarLevel'),
            Slider(
              value: sugarLevel.toDouble(),
              min: 0,
              max: 3,
              divisions: 3,
              label: ['None', '5fef', 'mazbout', 'karamel'][sugarLevel],
              onChanged: (double value) {
                setState(() {
                  sugarLevel = value.toInt();
                });
              },
            ),
          ],
        );
      case 'Ahwa Torky':
        return DropdownButtonFormField(
          value: coffeePreparation,
          decoration: InputDecoration(
            labelText: 'Preparation',
            border: OutlineInputBorder(),
          ),
          items:
              ['sada', 'mazbout', 'ziyada'].map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              coffeePreparation = newValue!;
            });
          },
        );
      default:
        return Container();
    }
  }

  Future<void> _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      final factory = drinkFactories[selectedDrinkType]!;
      final parameters = _getDrinkParameters();
      final drink = factory.createDrink(parameters);

      await widget.orderService.createOrder(
        customerName: _customerNameController.text,
        drink: drink,
        specialPreparation: _specialInstructionsController.text,
      );
      _customerNameController.clear();
      _specialInstructionsController.clear();
      setState(() {
        withMint = false;
        sugarLevel = 1;
        coffeePreparation = 'mazbout';
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Order added successfully!')));

      widget.onOrderAdded();
    }
  }

  Map<String, dynamic> _getDrinkParameters() {
    switch (selectedDrinkType) {
      case 'Tea':
        return {'withMint': withMint, 'sugarLevel': sugarLevel};
      case 'Ahwa Torky':
        return {'preparation': coffeePreparation};
      default:
        return {};
    }
  }
}