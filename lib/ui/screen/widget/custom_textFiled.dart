import 'package:flutter/material.dart';
import 'package:artificial/assets.dart';
import 'package:artificial/ui/screen/widget/custom_buttom.dart';

// ويدجت مخصصة لحقل إدخال النص
class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.keyboardType,
    this.dropdownItems,
    this.onChanged,
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
              ),
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.white),
              items: dropdownItems!
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: onChanged,
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
