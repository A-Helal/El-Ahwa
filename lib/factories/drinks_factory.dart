import 'package:omer_ahmed_mentorship/models/drinks_model.dart';

abstract class DrinksFactory {
  Drinks createDrink(Map<String, dynamic> parameters);

  String get drinkType;
}

class TeaDrink extends DrinksFactory {
  @override
  Drinks createDrink(Map<String, dynamic> parameters) {
    return Tea(
      withMint: parameters['withMint'] ?? false,
      numOfSugar: parameters['numOfSugar'] ?? 2,
    );
  }

  @override
  String get drinkType => "Wa7d shay";
}
class AhwaDrink extends DrinksFactory {
  @override
  Drinks createDrink(Map<String, dynamic> parameters) {
    return AhwaTorky(
      preparation: parameters['preparation']??"mazbout",
    );
  }

  @override
  String get drinkType => "wa7d 2hwaa";
}
