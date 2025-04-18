import 'dart:convert';

import 'package:pet_app/models/user_model_firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
Future<void> setUserData(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userMap = user.toFirestore();
      final userJson = jsonEncode(userMap);
      final success = await prefs.setString('user_data', userJson);
      if (!success) {
        throw Exception('Failed to save user data to SharedPreferences');
      }
      print('User data saved successfully');
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user_data');
      if (userJson != null) {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        return UserModel.fromFirestore(userMap);
      }
      return null;
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }

  Future<void> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final success = await prefs.remove('user_data');
      if (!success) {
        throw Exception('Failed to clear user data from SharedPreferences');
      }
    } catch (e) {
      print('Error clearing user data: $e');
      rethrow;
    }
  }


  Future<void> writeValue(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> deleteValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> clearAll(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
