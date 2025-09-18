abstract class Drinks {
  final String name;
  final double price;
  final String category;

  Drinks(this.name, this.price, this.category);

  String getDescription();

  double calculatePrice();

  String getFullDetails() {
    return "${getDescription()} - ${calculatePrice().toString()} EGP";
  }
}

class Tea extends Drinks {
  final bool withMint;
  final int numOfSugar;

  Tea({this.withMint = false, this.numOfSugar = 2})
    : super('wa7d shay', 3.0, 'Tea');

  @override
  double calculatePrice() {
    double totalPrice = price;
    if (withMint) totalPrice += 2.5;
    return totalPrice;
  }

  @override
  String getDescription() {
    String desc = "The Holy Tea ";
    if (withMint) desc += "with mint";
    if (numOfSugar == 0) {
      desc += "with no sugar";
    } else if (numOfSugar == 2) {
      desc += "Mano";
    } else if (numOfSugar > 2) {
      desc += "Karamel";
    }
    return desc;
  }
}

class AhwaTorky extends Drinks {
  final String preparation;

  AhwaTorky({this.preparation = "mazbout"})
    : super('Turkish Coffee', 10, 'Ahwa');

  @override
  double calculatePrice() {
    return price;
  }

  @override
  String getDescription() {
    return "wa7d 2hwaa $preparation";
  }
}
