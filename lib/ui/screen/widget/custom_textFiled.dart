import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onChanged;
  final double? dropdownMaxHeight;

  const CustomTextField({
    super.key,
    required this.label,
    this.keyboardType,
    this.dropdownItems,
    this.onChanged,
    this.dropdownMaxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: dropdownItems != null
          ? DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey[900],
              ),
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.white),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              items: dropdownItems!
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: onChanged,
              selectedItemBuilder: (context) => dropdownItems!
                  .map((item) => Text(
                        item,
                        style: TextStyle(color: Colors.white),
                      ))
                  .toList(),
              menuMaxHeight: dropdownMaxHeight ?? 200,
            )
          : TextField(
              decoration: InputDecoration(
                labelText: label,
                hintText: label,
                hintStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: keyboardType,
              style: TextStyle(color: Colors.white),
            ),
    );
  }
}
