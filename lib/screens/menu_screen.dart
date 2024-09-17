import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../services/api_service.dart';
import '../models/pizza.dart';
import 'checkout.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  late Future<List<Pizza>> futurePizzas;

  @override
  void initState() {
    super.initState();
    futurePizzas = ApiService().fetchPizzas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio de Pizzas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckoutScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Pizza>>(
        future: futurePizzas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar pizzas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma pizza disponível'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pizza = snapshot.data![index];
                return ListTile(
                  title: Text('${pizza.id}. ${pizza.nome}'),
                  subtitle: Text(pizza.descricao),
                  trailing: Text('R\$ ${pizza.preco.toStringAsFixed(2)}'),
                  onTap: () {
                    Provider.of<CartModel>(context, listen: false)
                        .addToCart(pizza);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('${pizza.nome} foi adicionado ao carrinho.'),
                    ));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
