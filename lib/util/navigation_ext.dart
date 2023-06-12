import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NavigationExt on BuildContext {
   Future<dynamic> goToPage(Widget page) {
     return Navigator.push(this, MaterialPageRoute(builder: (c) => page));
   }

   void goToPageAsRoute(Widget page) {
     Navigator.pushReplacement(this, MaterialPageRoute(builder: (c) => page));
   }

   void goBack<T extends Object?>([ T? result]) {
     Navigator.pop(this, result);
   }
}