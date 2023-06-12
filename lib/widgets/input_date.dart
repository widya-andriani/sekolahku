import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/util/date_ext.dart';
import 'package:sekolahku/util/dialog_ext.dart';

import '../res/dimen_res.dart';
import '../res/icon_res.dart';
import '../res/string_res.dart';
import 'input.dart';

class InputDate extends StatelessWidget {

  final String label;
  final TextEditingController textEditingController;
  final double marginTop;
  final ValueChanged<String>? onChanged;

  const InputDate({
    super.key,
    required this.label,
    required this.textEditingController,
    this.marginTop = DimenRes.size_16,
    this.onChanged
  });

  String? _validator(String? input) {
    if(input != null) {
      if(input.isEmpty) {
        return StringRes.required;
      }

      final dateTime = input.parse();
      if(dateTime != null) {
        if(dateTime.isBefore(DateTime(2000))) {
          return StringRes.minDateReached;
        } else if(dateTime.isAfter(DateTime(2020))) {
          return StringRes.maxDateReached;
        }
      } else {
        return StringRes.invalidBirthDate;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      label: label,
      marginTop: marginTop,
      readOnly: true,
      onTap: () => _showDataPicker(context),
      suffixIcon: IconButton(
        icon: const Icon(IconRes.dateRange),
        onPressed: () => _showDataPicker(context),
      ),
      controller: textEditingController,
      validator: (v) => _validator(v),
      onChanged: onChanged,
    );
  }

  void _showDataPicker(BuildContext context) async {
    final selectedDate = await context.showAppDatePicker();
    if(selectedDate != null) {
      textEditingController.text = selectedDate.format();
    }
  }

}