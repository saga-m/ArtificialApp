import 'package:flutter/material.dart';

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
        color: Colors.black, // لون الخلفية
        borderRadius: BorderRadius.circular(25), // تدوير الزوايا
        border: Border.all(color: Colors.white, width: 2), //  إضافة إطار أبيض
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSearch, // يتم استدعاؤه عند الضغط على "إدخال"
        style: TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
          hintText: "ابحث عن صنايعي الآن",
          hintStyle: TextStyle(color: Colors.yellow, fontSize: 16),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }
}
