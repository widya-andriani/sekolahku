import 'package:sekolahku/database/database_open_helper.dart';
import 'package:sekolahku/pref/user_pref.dart';
import 'package:sekolahku/repository/student_repository.dart';
import 'package:sekolahku/services/student_service.dart';
import 'package:sekolahku/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  static final _helper = DatabaseOpenHelper();
  static StudentRepository get _studentRepository => StudentRepositoryImpl(_helper);
  static StudentService get studentService => StudentServiceImpl(_studentRepository);
  static Future<SharedPreferences> get _sharedPreferences => SharedPreferences.getInstance();
  static UserPref get _userPreferences => UserPrefImpl(_sharedPreferences);
  static UserService get userService => UserServiceImpl(_userPreferences);

}