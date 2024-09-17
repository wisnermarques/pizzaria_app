import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../services/api_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  Future<void> _confirmOrder() async {
    final cart = Provider.of<CartModel>(context, listen: false);

    // Lógica para enviar o pedido para o backend
    final success = await ApiService().sendOrder(cart.items);

    // Verificar se o widget ainda está montado
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Pedido feito com sucesso!'
                : 'Erro ao finalizar o pedido.',
          ),
        ),
      );

      if (success) {
        cart.clearCart();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<CartModel>(
          builder: (context, cart, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cart.items[index];
                      return ListTile(
                        title: Text(cartItem.pizza.nome),
                        subtitle: Text(
                            'Quantidade: ${cartItem.quantity}, Preço: R\$ ${(cartItem.pizza.preco * cartItem.quantity).toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            // Remover item do carrinho
                            cart.removeFromCart(cartItem.pizza);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Total: R\$ ${cart.getTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _confirmOrder,
                  child: const Text('Confirmar Pedido'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
