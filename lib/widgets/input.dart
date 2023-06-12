import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/res/dimen_res.dart';

import '../res/color_res.dart';

class Input extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final double marginTop;
  final TextEditingController? controller;
  final int minLines;
  final Widget? suffixIcon;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const Input({
    super.key,
    required this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text, //default value text
    this.marginTop = DimenRes.size_0,
    this.controller,
    this.minLines = 1,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if(marginTop > DimenRes.size_0) SizedBox(height: marginTop,),
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        minLines: minLines,
        maxLines: minLines > 1 ? minLines : 1,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          label: Text(label, style: TextStyle(color: ColorRes.blueGrey),),
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          suffixIcon: suffixIcon
        )
      )
    ],);
  }

  InputBorder? outlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(DimenRes.size_16),
        borderSide: BorderSide(color: ColorRes.blueGrey, width: 2.0));
  }
}