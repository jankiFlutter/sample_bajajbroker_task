import 'package:flutter/material.dart';

import 'order_detail_screen.dart';

class UserDetailScreen extends StatelessWidget {
  final dynamic user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final orders = user['orders'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(user['name'])),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text('Order ID: ${order['id']}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailScreen(order: order),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
