import 'package:flutter/cupertino.dart';

import '../res/dimen_res.dart';
import '../res/string_res.dart';
import 'input.dart';

class InputPhoneNumber extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const InputPhoneNumber({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.onChanged
  });

  String? _validate(input) {
    if(input == null || input.isEmpty) {
      return StringRes.required;
    } else if(input.toString().length < 10){
      return StringRes.invalidPhoneNumber;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      label: label,
      marginTop: DimenRes.size_16,
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: (input) => _validate(input),
      onChanged: onChanged,
    );
  }

}