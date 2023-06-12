import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/navigation/app_navigation.dart';
import 'package:sekolahku/res/dimen_res.dart';
import 'package:sekolahku/util/dialog_ext.dart';
import 'package:sekolahku/util/snackbar_ext.dart';

import '../app_service.dart';
import '../model/student.dart';
import '../res/color_res.dart';
import '../res/string_res.dart';
import '../widgets/list.dart';

class StudentListPage extends StatefulWidget {
  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {

  void _startFormPage(BuildContext context) {
    context.startFormPage().then((dataChange) {
      if (dataChange is bool && dataChange) {
        setState(() {});
      }
    });
  }

  void _onSelectedItem(String action, Student student) {
    if (action == StringRes.edit) {
      context.startFormPage(student).then((dataChange) {
        if (dataChange is bool && dataChange) {
          setState(() {});
        }
      });
    } else if (action == StringRes.delete) {
      context.showConfirmationDialog("Are you Sure ?", () => _delete(student));
    } else {
      context.showErrorSnackBar(StringRes.unknownError);
    }
  }

  void _delete(Student student) async {
    var studentService = AppService.studentService;
    try {
      await studentService.delete(student);
      context.showSuccessSnackBar(StringRes.deleteSuccess);
      setState(() {});
    } catch (e, s) {
      print(s);
      context.showErrorSnackBar(e.toString());
    }
  }

  void _logout() {
    var userService = AppService.userService;
    context.showConfirmationDialog("Do you want to Logout?", () {
      userService.logout();
      context.startLoginPage();
    });
  }

  void _search() {
    context.startSearchPage();
  }

  Future<List<Student>> _onShowList() {
    final studentService = AppService.studentService;
    return studentService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringRes.addSiswa,
          style: TextStyle(color: ColorRes.white),
        ),
        backgroundColor: ColorRes.blueAccent,
        actions: [
          IconButton(
              onPressed: () => _search(),
              icon: Icon(
                Icons.search,
                size: DimenRes.size_35,
              ),
              color: ColorRes.white),
          IconButton(
              onPressed: () => _logout(),
              icon: Icon(
                Icons.exit_to_app_rounded,
                size: DimenRes.size_35,
              ),
              color: ColorRes.white),
        ],
      ),
      body: _showListStudent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startFormPage(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _showListStudent() {
    return FutureBuilder<List<Student>>(
        future: _onShowList(),
        builder: (c, s) {
          final data = s.data;
          print(data);
          if (data != null) {
            return ListView.separated(
                separatorBuilder: (c, pos) => const Divider(
                  height: DimenRes.size_1,
                ),
                itemCount: data.length,
                itemBuilder: (c, pos) => InkWell(
                  child: ListData(
                    student: data[pos],
                    onSelected: (action) =>
                        _onSelectedItem(action, data[pos]),
                  ),
                  onTap: () => context.startDetailPage( data[pos].id),
                ));
          }
          return Container();
        });
  }
}
