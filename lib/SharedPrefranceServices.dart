import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();

  factory SharedPrefHelper() => _instance;

  SharedPrefHelper._internal() {
    // init things inside this
  }

  // ignore: missing_return
  Future<dynamic> save(String key, dynamic value) async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    if (value is int) {
      return await sharedPreferences.setInt(key, value) as dynamic;
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value) as dynamic;
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value) as dynamic;
    } else if (value is String) {
      return await sharedPreferences.setString(key, value) as dynamic;
    } else if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value) as dynamic;
    }
  }

  Future<dynamic> get(String key) async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    // return await sharedPreferences.get(key) as Future<dynamic>;
    return sharedPreferences.get(key);
  }

  Future<dynamic> getWithDefault(String key, dynamic defValue) async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key) ?? defValue;
  }

// Future<bool> clear() async {
//   SharedPreferences sharedPreferences;
//   sharedPreferences = await SharedPreferences.getInstance();
//   return await sharedPreferences.clear();
// }
}