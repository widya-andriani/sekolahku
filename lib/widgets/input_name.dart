import 'package:flutter/cupertino.dart';

import '../res/string_res.dart';
import 'input.dart';

class InputName extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const InputName({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.onChanged
  });

  String? _validate(input) {
    if(input == null || input.isEmpty) {
      return StringRes.required;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      label: label,
      controller: controller,
      validator: (input) => _validate(input),
      onChanged: onChanged,
    );
  }

}