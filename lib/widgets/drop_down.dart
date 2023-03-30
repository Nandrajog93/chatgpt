import 'package:chatgpt/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String currentModel ="Model1";
  @override
  Widget build(BuildContext context) {
      return DropdownButton(
        dropdownColor: scaffoldBackgroundColor,
        iconEnabledColor: Colors.white,
      items: getModelsItem,
      value: currentModel,
      onChanged: (value) => {setState(() {
        currentModel =value.toString();
      })
      },
      );
  }
}