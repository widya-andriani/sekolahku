import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sekolahku/widgets/title_pop_up_menu_item.dart';

import '../res/color_res.dart';
import '../res/icon_res.dart';

class MenuItemConfig {
  final String title;
  final IconData icon;
  final Color iconColor;

  MenuItemConfig({
    required this.title,
    required this.icon,
    required this.iconColor
  });

  static PopupMenuItem<String> toTitlePopUpMenuItem(MenuItemConfig item) {
    return PopupMenuItem(
        value: item.title,
        child: TitlePopMenuItem(
          title: item.title,
          icon: item.icon,
          iconColor: item.iconColor,
        )
    );
  }
}

class PopUpMenu extends StatelessWidget {
  final List<MenuItemConfig> menuItems;
  final PopupMenuItemSelected<String>? onSelected;

  const PopUpMenu({
    super.key,
    required this.menuItems,
    this.onSelected
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        icon: const FaIcon(IconRes.ellipsisVertical, color: ColorRes.blueGrey),
        onSelected: onSelected,
        itemBuilder: (context) {
          return menuItems.map((e) => MenuItemConfig.toTitlePopUpMenuItem(e))
              .toList();
        }
    );
  }

}