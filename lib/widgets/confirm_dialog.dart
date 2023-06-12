import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/util/navigation_ext.dart';
import 'package:sekolahku/widgets/button.dart';

import '../res/dimen_res.dart';
import '../res/string_res.dart';

class ConfirmDialog extends StatelessWidget {

  final String message;
  final VoidCallback? onConfrim;

  const ConfirmDialog({
    super.key,
    required this.message,
    this.onConfrim
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(StringRes.deleteConfrimation),
      content: Text(message),
      actions: <Widget>[
        PrimaryButton(
          label: StringRes.confirm,
          isExpanded: false,
          onPressed: () {
            context.goBack();
            onConfrim?.call();
          },
        ),
        SizedBox(height: DimenRes.size_16,),
        PrimaryButton(
          label: StringRes.cancel,
          isExpanded: false,
          onPressed: () {
            context.goBack();
          },
        ),
      ],
    );
  }

}