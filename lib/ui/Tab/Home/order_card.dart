import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> workerData;

  const OrderCard({Key? key, required this.workerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(workerData["name"] ?? "عامل غير معروف"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(workerData["image"] ?? "assets/default.png", height: 100),
          Text(workerData["job"] ?? "المهنة غير محددة"),
          Text("التقييم: ${workerData["rating"] ?? "غير متوفر"} ⭐"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("إغلاق"),
        ),
      ],
    );
  }
}
