import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../res/color_res.dart';
import '../res/dimen_res.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double marginTop;
  final bool isExpanded;
  final bool enabled;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.marginTop = DimenRes.size_0,
    this.isExpanded = true,
    this.enabled = true
  });

  @override
  Widget build(BuildContext context) {
    // wajib onPressed dan child
    final buttonSize = isExpanded ? const Size(double.infinity, DimenRes.size_50) : null;
    return Column(children: [
      if(marginTop > DimenRes.size_0) SizedBox(height: marginTop,),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: buttonSize, backgroundColor: ColorRes.red),
        onPressed: enabled ? onPressed : null,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ))],);
  }
}
