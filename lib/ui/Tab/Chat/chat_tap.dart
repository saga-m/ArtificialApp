import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';

class ChatTap extends StatefulWidget {
  @override
  _ChatTapState createState() => _ChatTapState();
}

class _ChatTapState extends State<ChatTap> {
  List<Map<String, String>> chatList = [
    {"name": "أحمد", "message": "كيف حالك؟", "image": AppImages.work},
    {"name": "محمد", "message": "عندي مشكلة بالموتور", "image": AppImages.work},
    {"name": "سالم", "message": "تمام، متى متفرغ؟", "image": AppImages.work},
    {"name": "حسين", "message": "أنا في الطريق", "image": AppImages.work},
    {"name": "يوسف", "message": "تم إصلاح المشكلة", "image": AppImages.work},
  ];

  String? selectedChat; // لمعرفة المحادثة المفتوحة حاليًا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          //  الشريط الجانبي لقائمة المحادثات
          Container(
            width: 100,
            color: Colors.black,
            child: ListView(
              children: chatList.map((chat) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedChat = chat["name"];
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(chat["image"]!),
                        ),
                        SizedBox(height: 5),
                        Text(
                          chat["name"]!,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          //  منطقة الدردشة
          Expanded(
            child: Column(
              children: [
                //  العنوان العلوي باسم الشخص
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.yellow,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      selectedChat ?? "اختر محادثة",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // ✅ رسائل الدردشة
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("السلام عليكم"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "وعليكم السلام، عندي مشكلة في موتور المياه والموتور مش شغال",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ✅ شريط إدخال النص
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.mic, color: Colors.yellow),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white10,
                            hintText: "اكتب رسالة...",
                            hintStyle: TextStyle(color: Colors.white60),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.more_horiz, color: Colors.yellow),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
