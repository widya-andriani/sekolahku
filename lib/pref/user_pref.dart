import 'package:shared_preferences/shared_preferences.dart';

abstract class UserPref {
  Future<void> save(String token);
  Future<void> clear();
  Future<String?> getToken();
}

class UserPrefImpl extends UserPref {
  final Future<SharedPreferences> preferences;
  final String key = "TOKEN";
  UserPrefImpl(this.preferences);

  @override
  Future<void> clear() async{
    (await preferences).setString(key, "");
  }

  @override
  Future<String?> getToken() async {
    return (await preferences).getString(key);
  }

  @override
  Future<void> save(String token) async{
    (await preferences).setString(key, token);
  }

}