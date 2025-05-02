import 'package:flutter/material.dart';


class OrderDetailScreen extends StatelessWidget {
  final dynamic order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final items = order['items'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text('Order ${order['id']}')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text('Quantity: ${item['quantity']}'),
          );
        },
      ),
    );
  }
}
