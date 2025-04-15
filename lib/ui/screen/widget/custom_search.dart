import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSearch,
        style: TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.find_an_industrialist_now,
          hintStyle: TextStyle(color: Colors.yellow, fontSize: 16),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }
}
