import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';


class ApiService {
  final String url =
      'https://mocki.io/v1/66181e8d-f42c-4cc4-8f77-aa72c573b3a9';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('janki');
      print(data);
      final List usersJson = data['users'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
