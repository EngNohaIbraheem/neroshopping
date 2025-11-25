import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPerferences;

  static initCashHeLper() async {
    sharedPerferences = await SharedPreferences.getInstance();
  }

  static Future<Object?> saveData(

      {required MyCashKey key, required dynamic value}) async {
    debugPrint("SharedPrefHelper : setData with key :$key and value  :$value");

    if (value is String) {
      return sharedPerferences.setString(key.name, value);
    }
    if (value is int) {
      return sharedPerferences.setInt(key.name, value);
    }
    if (value is bool) {
      return sharedPerferences.setBool(key.name, value);
    }
  }

  // static dynamic getData({required MyCashKey key}) {
  //   debugPrint('sharedPerferncesHelper :getData with key :$key');
  // }
  static dynamic getData({required MyCashKey key}) {
    debugPrint('sharedPerferncesHelper :getData with key :$key');
    return sharedPerferences.get(key.name);
  }

  static Future<bool> removeData({required MyCashKey key}) async {
    return sharedPerferences.remove(key.name);
  }
  static Future<bool> clearAllData (
      {required MyCashKey key, required dynamic value}) async {
    debugPrint ('sharedPerfernces : all data has been cleared');
    return sharedPerferences.clear();
  }

}

enum MyCashKey {
  token,
}
