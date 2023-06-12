import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/navigation/app_navigation.dart';
import 'package:sekolahku/util/dialog_ext.dart';
import 'package:sekolahku/util/snackbar_ext.dart';

import '../app_service.dart';
import '../model/student.dart';
import '../res/dimen_res.dart';
import '../res/string_res.dart';
import '../widgets/list.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
            child: Padding(
                padding: EdgeInsets.all(DimenRes.size_8),
                child: SearchBar(
                    hintText: StringRes.search,
                    controller: _searchCtrl,
                    onChanged: (s) => _onSearch(s),
                    leading: IconButton(
                        onPressed: () { context.startListPage();  },
                        icon: Icon(Icons.arrow_back_ios_new_rounded)),
          ),
        )),
      ),
      body: _showListStudent(),
    );
  }

  void _onSearch(String s) {
    setState(() {

    });
  }

  Future<List<Student>> _onShowList() {
    final studentService = AppService.studentService;
    var name = _searchCtrl.text;
    return studentService.getAllByName(name);
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
                      onTap: () => context.startDetailPage(data[pos].id),
                    ));
          }
          return Container();
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
}
