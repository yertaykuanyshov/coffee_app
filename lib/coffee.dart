import 'dart:math';

class Coffee {
  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });

  final String name;
  final String image;
  final double price;
}

final names = [
  'Caramel Macchiato',
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Americano'
];

final coffees = List.generate(12, (index) {
  final idx = index + 1;

  return Coffee(
    name: names[Random().nextInt(names.length)],
    image: 'assets/images/$idx.png',
    price: 1.99,
  );
}).toList();
