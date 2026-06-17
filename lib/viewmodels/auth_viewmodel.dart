import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/datasources/remote_data_source.dart';
import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  User? currentUser;
  bool isLoading = false;
  String? errorMessage;

  Future<void> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final username = prefs.getString('auth_username');
    final firstName = prefs.getString('auth_firstname');
    
    if (token != null && username != null) {
      currentUser = User(id: 0, username: username, firstName: firstName ?? '', token: token);
      notifyListeners();
    }
  }

  Future<bool> login(String username, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      currentUser = await _remoteDataSource.login(username, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', currentUser!.token);
      await prefs.setString('auth_username', currentUser!.username);
      await prefs.setString('auth_firstname', currentUser!.firstName);
      
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    currentUser = null;
    notifyListeners();
  }
}