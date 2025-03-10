import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:artificial/ui/Tab/Profile/profile_tap.dart';
import 'package:artificial/ui/screen/widget/custom_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeTap extends StatelessWidget {
  final Function(int) onTabChanged;
  final Function(Map<String, dynamic>) onWorkerSelected;

  HomeTap({
    Key? key,
    required this.onTabChanged,
    required this.onWorkerSelected,
  }) : super(key: key);

  final List<Map<String, dynamic>> workers = [
    {
      "image": AppImages.work,
      "name": "محمد طلعت",
      "profession": "سباك",
      "rating": 5.0,
    },
    {
      "image": AppImages.work,
      "name": "أحمد عبد الله",
      "profession": "كهربائي",
      "rating": 4.5,
    },
    {
      "image": AppImages.work,
      "name": "يوسف حسن",
      "profession": "نجار",
      "rating": 4.8,
    },
  ];

  final List<String> ads = [
    AppImages.an1,
    AppImages.an2,
    AppImages.an3,
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // ✅ **الإعلانات مع المؤشر**
          Container(
            height: 200,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: ads.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        ads[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                // المؤشر
                Positioned(
                  bottom: 10,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: ads.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.yellow,
                      dotColor: Colors.white,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: workers.length,
              itemBuilder: (context, index) {
                final worker = workers[index];
                return WorkerCard(
                  image: worker["image"] ?? AppImages.work,
                  name: worker["name"] ?? "غير معروف",
                  profession: worker["profession"] ?? "غير محدد",
                  rating: worker["rating"] ?? 0.0,
                  onOrderPressed: () {
                    onWorkerSelected(worker);
                    onTabChanged(4);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
