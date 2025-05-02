import 'package:flutter/material.dart';
import '../models/user.dart';
import '../service/api_service.dart';


class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<User> _users = [];
  bool _isLoading = true;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  UserProvider() {
    fetchUsers();
  }

  void fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _apiService.fetchUsers();
    } catch (e) {
      _users = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
