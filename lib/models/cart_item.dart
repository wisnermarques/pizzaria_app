import 'pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem({required this.pizza, required this.quantity});

  String get nome => pizza.nome;
  String get descricao => pizza.descricao;
  double get preco => pizza.preco;
}
