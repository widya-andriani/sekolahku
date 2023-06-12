import 'package:sekolahku/pref/user_pref.dart';

abstract class UserService {
  Future<void> login(String username, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
}

class UserServiceImpl extends UserService {
  final UserPref userPref;

  UserServiceImpl(this.userPref);

  @override
  Future<bool> isLoggedIn() async{
    final savedToken = await userPref.getToken();
    return savedToken != null && savedToken.isNotEmpty;
  }

  @override
  Future<void> login(String username, String password) async{
    if(username == "admin" && password == "admin") {
      await userPref.save("$username&&$password");
      return;
    }
    throw Exception("Invalid credential");
  }

  @override
  Future<void> logout() async {
    await userPref.clear();
  }

}