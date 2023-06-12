import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/app_service.dart';
import 'package:sekolahku/widgets/list_detail_student.dart';
import 'package:sekolahku/widgets/loading_dialog.dart';

import '../model/student.dart';
import '../res/color_res.dart';
import '../res/dimen_res.dart';
import '../res/icon_res.dart';
import '../res/string_res.dart';

class DetailPage extends StatelessWidget {
  final int id;

  DetailPage({super.key, required this.id});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text(
  //           StringRes.addSiswa,
  //           style: TextStyle(color: ColorRes.white),
  //         ),
  //         backgroundColor: ColorRes.blueAccent,
  //       ),
  //       body: Column(children: [
  //         Icon(IconRes.person, size: DimenRes.size_200,),
  //         const SizedBox(height: DimenRes.size_16,),
  //         Expanded(child: ListDetailStudent(student: student,))
  //       ],));
  // }

  Widget _onCreatePage(Student? student) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            StringRes.addSiswa,
            style: TextStyle(color: ColorRes.white),
          ),
          backgroundColor: ColorRes.blueAccent,
        ),
        body: Column(children: [
          Icon(IconRes.person, size: DimenRes.size_200,),
          const SizedBox(height: DimenRes.size_16,),
          Expanded(child: ListDetailStudent(student: student,))
        ],));
  }

  @override
  Widget build(BuildContext context) {
    final studentService = AppService.studentService;
    return CustomFutureBuilder(
        future: studentService.findById(id),
        onShowDataWidget: (data) => _onCreatePage(data),
        noDataWidget: _onCreatePage(null),
        loadingWidget: LoadingBlocker(message: "Loading Detail Student", toBlock: _onCreatePage(null),));
  }

}