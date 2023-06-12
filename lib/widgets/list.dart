import 'package:flutter/material.dart';
import 'package:sekolahku/res/color_res.dart';
import 'package:sekolahku/widgets/pop_up_menu.dart';

import '../model/student.dart';
import '../res/dimen_res.dart';
import '../res/icon_res.dart';
import '../res/string_res.dart';

class ListData extends StatelessWidget {
  final Student student;
  final PopupMenuItemSelected<String>? onSelected;

  const ListData({
    super.key,
    required this.student,
    this.onSelected
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DimenRes.size_16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: DimenRes.size_50,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.student.fullName),
                Text(this.student.gender)
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(this.student.grade),
              Text(this.student.id.toString())
            ],
          ),
          PopUpMenu(
            onSelected: onSelected,
            menuItems: [
              MenuItemConfig(
                  title: StringRes.edit,
                  icon: IconRes.edit,
                  iconColor: ColorRes.blueGrey),
              MenuItemConfig(
                  title: StringRes.delete,
                  icon: IconRes.delete,
                  iconColor: ColorRes.red)
            ],
          )
        ],
      ),
    );
  }
}
