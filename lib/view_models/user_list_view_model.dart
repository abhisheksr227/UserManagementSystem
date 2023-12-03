
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class UserListViewModel extends ChangeNotifier {
  late Box<User> _userBox;

  UserListViewModel() {
    _userBox = Hive.box<User>('users');
  }

  List<User> get users => _userBox.values.toList();

  void addUser(User newUser) {
    _userBox.put(newUser.id, newUser);
    notifyListeners(); // Notify listeners
  }

  void deleteUser(String userId) {
    _userBox.delete(userId);
    notifyListeners(); // Notify listeners
  }



  void dispose() {
    Hive.close();
    super.dispose();
  }
}
