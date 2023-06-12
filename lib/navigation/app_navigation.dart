import 'package:flutter/cupertino.dart';
import 'package:sekolahku/model/student.dart';
import 'package:sekolahku/pages/detail_page.dart';
import 'package:sekolahku/pages/login_page.dart';
import 'package:sekolahku/pages/search_page.dart';
import 'package:sekolahku/pages/student_list_page.dart';
import 'package:sekolahku/pages/student_page.dart';
import 'package:sekolahku/util/navigation_ext.dart';

extension AppNavigationExt on BuildContext {
  Future<dynamic> startFormPage([Student? student]) => goToPage(StudentPage(student: student,));
  void startLoginPage() => goToPageAsRoute(LoginPage());
  void startListPage() => goToPageAsRoute(StudentListPage());
  void startSearchPage() => goToPageAsRoute(SearchPage());
  Future<dynamic> startDetailPage(int id) => goToPage(DetailPage(id: id));
}