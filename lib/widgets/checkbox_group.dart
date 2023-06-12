import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../res/dimen_res.dart';

class CheckBoxController extends ValueNotifier<List<String>> {
  final List<String> options;
  CheckBoxController(super.value, this.options);
  //value adalah dari ValueNotifier, pilihan yang sudah dipilih akan disimpan di value
  //options adalah pilihan yang tersedia

}

class CheckBoxGroup extends StatefulWidget {
  final double marginTop;
  final CheckBoxController controller;
  final String label;

  const CheckBoxGroup({
    super.key,
    required this.marginTop,
    required this.controller,
    required this.label,
  });

  @override
  State<CheckBoxGroup> createState() => _CheckBoxGroupState();
}

class _CheckBoxGroupState extends State<CheckBoxGroup> {
  void _updateSelectedOptins(bool? isSelected, String option) {
    final selectedOption = widget.controller.value;
    if(isSelected == null) return;
    if(isSelected) {
      if(!selectedOption.contains(option)) {
        selectedOption.add(option);
      }
    } else {
      if(selectedOption.contains(option)) {
        selectedOption.remove(option);
      }
    }

    setState(() {
      widget.controller.value = selectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if(widget.marginTop > DimenRes.size_0) widgets.add(SizedBox(height: widget.marginTop,));
    widgets.add(Text(widget.label));
    List<Widget> checkBoxes = widget.controller.options.map((option) =>
        InkWell(
          onTap: () => _updateSelectedOptins(!widget.controller.value.contains(option), option),
          child: Row(
            children: [
              Checkbox(
                value: widget.controller.value.contains(option),
                onChanged: (isSelected)  {
                  _updateSelectedOptins(isSelected, option);
                },
              ),
              const SizedBox(width: DimenRes.size_8,),
              Text(option),
            ],
          ),
        )).toList();
    widgets.addAll(checkBoxes);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}