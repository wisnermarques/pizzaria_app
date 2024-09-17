import 'package:flutter/material.dart';
import 'pizza.dart';
import 'cart_item.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Pizza pizza) {
    final existingItem = _items.firstWhere(
      (item) => item.pizza.id == pizza.id,
      orElse: () => CartItem(pizza: pizza, quantity: 1),
    );

    if (_items.contains(existingItem)) {
      existingItem.quantity += 1;
    } else {
      _items.add(CartItem(pizza: pizza, quantity: 1));
    }

    notifyListeners();
  }

  void removeFromCart(Pizza pizza) {
    _items.removeWhere((item) => item.pizza.id == pizza.id);
    notifyListeners();
  }

  double getTotalPrice() {
    return _items.fold(
        0, (total, item) => total + item.pizza.preco * item.quantity);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
