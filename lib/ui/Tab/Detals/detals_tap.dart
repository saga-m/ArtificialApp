// DetalsTap

import 'package:flutter/material.dart';

class DetalsTap extends StatefulWidget {
  const DetalsTap({super.key});

  @override
  State<DetalsTap> createState() => _DetalsTapState();
}

class _DetalsTapState extends State<DetalsTap> {
  bool _isDropdownVisible = false;
  TextEditingController _questionController = TextEditingController();
  List<Map<String, String>> _questions = [];

  // ✅ القوائم المتاحة
  final List<String> _governorates = [
    "اختر المحافظة",
    "القاهرة",
    "الإسكندرية",
    "الجيزة"
  ];
  final List<String> _crafts = ["اختر الصنعة", "سباك", "كهربائي", "نجار"];

  // ✅ تعيين القيم الافتراضية من القائمة نفسها
  late String _selectedGovernorate = _governorates[0];
  late String _selectedCraft = _crafts[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ممكن تسأل عن مشكلة معينة، والصنايعية\nهترد عليك 😏",
                  style: TextStyle(
                    color: Color(0xffffda1a),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDropdownVisible = !_isDropdownVisible;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.white70),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "شارك سؤالك لكل الصنايعية 🔍",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isDropdownVisible)
                  Column(
                    children: [
                      SizedBox(height: 10),

                      // ✅ اختيار المحافظة
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedGovernorate,
                          dropdownColor: Colors.grey[900],
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(color: Colors.white),
                          items: _governorates.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) _selectedGovernorate = value;
                            });
                          },
                        ),
                      ),

                      SizedBox(height: 10),

                      // ✅ اختيار الصنعة
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedCraft,
                          dropdownColor: Colors.grey[900],
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(color: Colors.white),
                          items: _crafts.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) _selectedCraft = value;
                            });
                          },
                        ),
                      ),

                      SizedBox(height: 10),

                      // ✅ إدخال السؤال
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _questionController,
                          decoration: InputDecoration(
                            hintText: "اكتب سؤالك هنا...",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      SizedBox(height: 10),

                      // ✅ زر مشاركة السؤال
                      ElevatedButton(
                        onPressed: () {
                          if (_questionController.text.isNotEmpty &&
                              _selectedGovernorate != _governorates[0] &&
                              _selectedCraft != _crafts[0]) {
                            setState(() {
                              _questions.add({
                                "title": _questionController.text,
                                "description":
                                    "محافظة $_selectedGovernorate - صنعة $_selectedCraft",
                                "time": "تم النشر الآن",
                                "comments": "التعليقات: 0",
                              });

                              _isDropdownVisible = false;
                              _questionController.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffffda1a),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "شارك السؤال",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // ✅ عرض الأسئلة بعد الإضافة
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return _buildOrderItem(
                  title: _questions[index]["title"]!,
                  description: _questions[index]["description"]!,
                  time: _questions[index]["time"]!,
                  comments: _questions[index]["comments"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ✅ دالة بناء عنصر السؤال
  Widget _buildOrderItem({
    required String title,
    required String description,
    required String time,
    required String comments,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: TextStyle(color: Colors.white54, fontSize: 12)),
              Text(comments,
                  style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
