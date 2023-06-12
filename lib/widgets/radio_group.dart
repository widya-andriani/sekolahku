import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/res/dimen_res.dart';

import '../res/color_res.dart';

class RadioGroup extends StatefulWidget {
  final String label;
  final List<String> options;
  final TextEditingController controller;
  final double marginTop;

  const RadioGroup({
    super.key,
    required this.options,
    required this.controller,
    required this.label,
    this.marginTop = DimenRes.size_0,
  });

  @override
  State<RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.marginTop > DimenRes.size_0)
          SizedBox(
            height: widget.marginTop,
          ),
        Text(
          widget.label,
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
        Row(
            children: widget.options
                .map((option) => Expanded(
                      child:
                      ListTile(
                          title: Text(option,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: ColorRes.blueGrey,
                            )),
                      onTap: () {
                        setState(() {
                          widget.controller.text = option;
                        });
                      },
                      leading: Radio<String>(
                        value: option,
                        activeColor: ColorRes.blueGrey,
                        groupValue: widget.controller.text,
                        onChanged: (selectedOption) {
                          if (selectedOption != null) {
                            setState(() {
                              widget.controller.text = selectedOption;
                            });
                          }
                        },
                      ),
                    )))
                .toList())
      ],
    );
  }
}
