class Item {
  final String name;
  final int quantity;

  Item({required this.name, required this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(name: json['name'], quantity: json['quantity']);
  }
}

class Order {
  final String id;
  final List<Item> items;

  Order({required this.id, required this.items});

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsList = (json['items'] as List)
        .map((item) => Item.fromJson(item))
        .toList();
    return Order(id: json['id'], items: itemsList);
  }
}

class User {
  final String name;
  final List<Order> orders;

  User({required this.name, required this.orders});

  factory User.fromJson(Map<String, dynamic> json) {
    var ordersList = (json['orders'] as List)
        .map((order) => Order.fromJson(order))
        .toList();
    return User(name: json['name'], orders: ordersList);
  }
}
