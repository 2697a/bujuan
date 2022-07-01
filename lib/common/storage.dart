import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储
class StorageUtil {
  static final StorageUtil _instance = StorageUtil._();

  factory StorageUtil() => _instance;
  static SharedPreferences? _prefs;

  StorageUtil._();

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs!.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String? jsonString = _prefs!.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setBool(String key, bool val) {
    return _prefs!.setBool(key, val);
  }

  bool getBool(String key) {
    bool? val = _prefs!.getBool(key);
    return val ?? false;
  }

  Future<bool> setString(String key, String val) {
    return _prefs!.setString(key, val);
  }

  String getString(String key) {
    String? val = _prefs!.getString(key);
    return val ?? '';
  }

  Future<bool> setInt(String key, int val) {
    return _prefs!.setInt(key, val);
  }

  int getInt(String key) {
    int? val = _prefs!.getInt(key);
    return val ?? 0;
  }

  Future<bool> setStringList(String key, List<String> val) {
    return _prefs!.setStringList(key, val);
  }

  List<String> getStringList(String key) {
    List<String>? val = _prefs!.getStringList(key);
    return val ?? [];
  }

  Future<bool> remove(String key) {
    return _prefs!.remove(key);
  }
}
