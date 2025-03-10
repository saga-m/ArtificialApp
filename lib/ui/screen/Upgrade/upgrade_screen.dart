import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpgradeScreen extends StatefulWidget {
  static const String routeName = '/upgrade-screen';

  @override
  _UpgradeScreenState createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  String? selectedPlan;
  String subscriptionType = "الاشتراك السنوي";

  // أسعار الخطط
  final Map<String, int> yearlyPrices = {
    "الحساب البلاتينيوم": 100,
    "الحساب الذهبي": 80,
    "الحساب الفضي": 50
  };

  final Map<String, int> monthlyPrices = {
    "الحساب البلاتينيوم": 10,
    "الحساب الذهبي": 8,
    "الحساب الفضي": 5
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlack,
        elevation: 0,
        leading: SizedBox(),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "🌟 ترقية الحساب",
              style: TextStyle(
                  color: AppColors.primaryGold,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                value: subscriptionType,
                dropdownColor: Colors.black,
                icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.white, fontSize: 16),
                items:
                    ["الاشتراك الشهري", "الاشتراك السنوي"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    subscriptionType = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildUpgradeCard("الحساب البلاتينيوم", Colors.purple, [
                      {
                        "text": "ضع صفحتك في الصفحة الرئيسية",
                        "icon": AppImages.UpgradeProfile
                      },
                      {
                        "text": "ضع إعلاناتك في الصفحة الرئيسية",
                        "icon": AppImages.ad2
                      },
                      {
                        "text": "منع إعلانات داخل التطبيق",
                        "icon": AppImages.ad
                      },
                    ]),
                    _buildUpgradeCard("الحساب الذهبي", AppColors.primaryGold, [
                      {
                        "text": "ضع صفحتك في الصفحة الرئيسية",
                        "icon": AppImages.UpgradeProfile
                      },
                      {
                        "text": "منع إعلانات داخل التطبيق",
                        "icon": AppImages.ad
                      },
                    ]),
                    _buildUpgradeCard(
                        "الحساب الفضي",
                        Colors.white,
                        [
                          {
                            "text": "ضع صفحتك في الصفحة الرئيسية",
                            "icon": AppImages.UpgradeProfile
                          },
                        ],
                        textColor: Colors.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradeCard(
      String title, Color color, List<Map<String, String>> features,
      {Color textColor = Colors.white}) {
    bool isSelected = selectedPlan == title;

    // تحديد السعر بناءً على نوع الاشتراك
    int price = subscriptionType == "الاشتراك السنوي"
        ? yearlyPrices[title]!
        : monthlyPrices[title]!;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = isSelected ? null : title;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features.map((feature) {
                return Row(
                  children: [
                    SvgPicture.asset(
                      feature["icon"]!,
                      width: 25,
                      height: 25,
                      colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                    ),
                    SizedBox(width: 8),
                    Text(feature["text"]!,
                        style: TextStyle(color: textColor, fontSize: 14)),
                  ],
                );
              }).toList(),
            ),
            if (isSelected) ...[
              Divider(color: textColor.withOpacity(0.5)),
              Text("نوع الاشتراك: $subscriptionType",
                  style: TextStyle(color: textColor, fontSize: 16)),
              Text("رسوم الاشتراك: $price ج.م",
                  style: TextStyle(
                      color: textColor.withOpacity(0.8),
                      fontSize: 14,
                      fontStyle: FontStyle.italic)),
              SizedBox(height: 10),
              Text("اختر طريقة الدفع",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/instapay.svg", width: 40),
                  SizedBox(width: 10),
                  SvgPicture.asset("assets/images/vodafone_cash.svg",
                      width: 40),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("اشترك الآن"),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
