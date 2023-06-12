import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/model/item_detail.dart';
import 'package:sekolahku/res/dimen_res.dart';

import '../model/ItemDetailView.dart';
import '../model/student.dart';
import '../res/icon_res.dart';
import '../res/string_res.dart';
import 'list.dart';

class ListDetailStudent extends StatelessWidget {

  final Student? student;

  ListDetailStudent({
    super.key,
    required this.student
  });

  List<ItemDetail> values = [];

  void initData() {
    values.add(ItemDetail(iconData: IconRes.person, data1: student?.fullName, data2: StringRes.name));
    values.add(ItemDetail(iconData: IconRes.phone, data1: student?.mobilePhone, data2: StringRes.phoneNumber));
    values.add(ItemDetail(iconData: IconRes.gender, data1: student?.gender, data2: StringRes.gender));
    values.add(ItemDetail(iconData: IconRes.grade, data1: student?.grade, data2: StringRes.grade));
    values.add(ItemDetail(iconData: IconRes.address, data1: student?.address, data2: StringRes.address));
    values.add(ItemDetail(iconData: IconRes.hobbies, data1: student?.hobbies.join(", "), data2: StringRes.hobi));
  }


  @override
  Widget build(BuildContext context) {
    initData();
    return ListView.separated(
      separatorBuilder: (c, pos) => const Divider(height: DimenRes.size_1,),
      itemCount: values.length,
      itemBuilder: (c, pos) => ItemDetailView(itemDetail: values[pos])
    );
  }


}