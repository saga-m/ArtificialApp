import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> workerData;

  const OrderCard({Key? key, required this.workerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rating = (workerData["rating"] ?? 0).toDouble().clamp(0, 5);
    List<dynamic> reviews = workerData["reviews"] ?? [];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGold,
        title: Text(AppLocalizations.of(context)!.profile,
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double avatarRadius = constraints.maxWidth * 0.15;
          double fontSize = constraints.maxWidth * 0.05;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage:
                      AssetImage(workerData["image"] ?? "assets/default.png"),
                ),
                const SizedBox(height: 10),
                Text(
                  workerData["name"] ?? "اسم غير متوفر",
                  style: TextStyle(
                      color: AppColors.primaryGold,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  workerData["job"]?.toString().trim().isNotEmpty == true
                      ? workerData["job"]
                      : "المهنة غير متوفرة",
                  style:
                      TextStyle(color: Colors.white, fontSize: fontSize * 0.8),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color:
                          index < rating ? AppColors.primaryGold : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: reviews.isNotEmpty
                      ? ListView.builder(
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            return ListTile(
                              title: Text(
                                  review["name"] ??
                                      AppLocalizations.of(context)!,
                                  style:
                                      TextStyle(color: AppColors.primaryGold)),
                              subtitle: Text(
                                  review["comment"] ??
                                      AppLocalizations.of(context)!.no_comment,
                                  style: const TextStyle(color: Colors.white)),
                              leading: Icon(Icons.star,
                                  color: AppColors.primaryGold),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            AppLocalizations.of(context)!
                                .there_are_no_reviews_yet,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGold,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context, workerData);
                      },
                      icon: Icon(Icons.shopping_cart, color: Colors.black),
                      label: Text(AppLocalizations.of(context)!.order_now,
                          style: TextStyle(
                              color: Colors.black, fontSize: fontSize * 0.8)),
                    ),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primaryGold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context, {
                          "tabIndex": 2,
                          "workerData": workerData, // ⬅️ نضيف بيانات العامل
                        });
                      },
                      icon: Icon(Icons.chat, color: AppColors.primaryGold),
                      label: Text(
                        AppLocalizations.of(context)!.chat,
                        style: TextStyle(
                          color: AppColors.primaryGold,
                          fontSize: fontSize * 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
