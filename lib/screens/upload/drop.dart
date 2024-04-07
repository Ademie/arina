import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Drop extends StatefulWidget {
  const Drop({super.key});

  @override
  State<Drop> createState() => _DropState();
}

class _DropState extends State<Drop> {

  

  final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];

String? selectedValue;

@override
Widget build(BuildContext context) {
  return  DropdownButtonHideUnderline(
    child: DropdownButton2<String>(
      isExpanded: true,
      hint: Text(
        'Select Item',
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      items: items
          .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      value: selectedValue,
      onChanged: (String? value) {
        setState(() {
          selectedValue = value;
        });
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        width: 140,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
      ),
    ),
  );
  
}
}