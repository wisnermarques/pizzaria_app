import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_item.dart';
import '../models/pizza.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api/pizzas/';
  static const String apiUrl = "http://127.0.0.1:8000/api/pedidos/";

  Future<List<Pizza>> fetchPizzas() async {
    final response = await http.get(Uri.parse(baseUrl));

    final utf8Body = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8Body);
      return jsonResponse.map((pizza) => Pizza.fromJson(pizza)).toList();
    } else {
      throw Exception('Failed to load pizzas');
    }
  }

  Future<bool> sendOrder(List<CartItem> items) async {
    try {
      List<Map<String, dynamic>> orderItems = items
          .map((item) => {
                'pizza_id': item.pizza.id,
                'quantity': item.quantity,
              })
          .toList();

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'items': orderItems}),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // print('Erro ao enviar pedido: $e');
      return false;
    }
  }
}
