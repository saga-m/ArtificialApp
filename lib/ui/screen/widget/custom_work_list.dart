import 'package:artificial/assets.dart';
import 'package:artificial/ui/Tap/Profile/profile_tap.dart';
import 'package:artificial/ui/screen/widget/custom_card.dart';
import 'package:flutter/material.dart';

class WorkersList extends StatelessWidget {
  final List<Map<String, String>> workers = [
    {
      "name": "محمد طلعت",
      "job": "سباك",
      "rating": "5",
      "image": AppImages.work
    },
    {
      "name": "أحمد خالد",
      "job": "نجار",
      "rating": "4",
      "image": AppImages.work
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: workers.length,
      itemBuilder: (context, index) {
        final worker = workers[index];

        return WorkerCard(
          name: worker["name"] ?? "غير معروف",
          profession: worker["job"] ?? "غير محدد",
          rating: double.tryParse(worker["rating"] ?? "0") ?? 0.0,
          image: worker["image"] ?? "assets/default.png",
          onOrderPressed: () {
            print(" تم الضغط على اطلب الآن لـ ${worker['name']}");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileTap(
                  workerData: worker,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
