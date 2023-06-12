import 'package:flutter/material.dart';
import 'package:sekolahku/util/navigation_ext.dart';
import 'package:sekolahku/widgets/confirm_dialog.dart';

import '../widgets/loading_dialog.dart';

typedef OnGetResult<T> = Function(T result);
typedef OnGetError = Function(Object error, Object stackTrace);

extension DialogExt on BuildContext {

  Future<DateTime?> showAppDatePicker() async {
    return await showDatePicker(
        context: this,
        initialDate: DateTime.now(),
        firstDate: DateTime(1998),
        lastDate: DateTime(2024)
    );
  }

  void showConfirmationDialog(String message, VoidCallback onConfirm) {
    showDialog(
        context: this,
        builder: (c) =>ConfirmDialog(message: message, onConfrim: onConfirm)
    );
  }

  void showLoadingDialog<T>({
    required String message,
    required Future<T> future,
    required OnGetResult<T> onGetResult,
    required OnGetError onGetError
  }) async {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (context) => LoadingDialog(message: message)
    );
    await Future.delayed(const Duration(seconds: 5));
    try {
      final result = await future;
      goBack();
      onGetResult.call(result);
    } catch(e, s) {
      //debugError(e, s);
      goBack();
      onGetError.call(e, s);
    }
  }
}