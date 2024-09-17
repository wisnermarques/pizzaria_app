import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text('O carrinho está vazio.'))
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final cartItem = cart.items[index];
                return ListTile(
                  title: Text(cartItem.pizza.nome),
                  subtitle: Text('Quantidade: ${cartItem.quantity}'),
                  trailing: Text(
                      'R\$ ${(cartItem.pizza.preco * cartItem.quantity).toStringAsFixed(2)}'),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: cart.items.isEmpty
              ? null
              : () {
                  // Lógica para fechar o pedido
                  Navigator.pushNamed(context, '/checkout');
                },
          child: const Text('Fechar Pedido'),
        ),
      ),
    );
  }
}
