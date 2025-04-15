import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class UpgradeScreen extends StatefulWidget {
  static const String routeName = '/upgrade-screen';

  @override
  _UpgradeScreenState createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  String? selectedPlan;
  String subscriptionType = "الاشتراك السنوي";

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
              AppLocalizations.of(context)!.upgrade_account,
              style: TextStyle(
                  color: AppColors.primaryGold,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSubscriptionOption(
                    AppLocalizations.of(context)!.monthly_sub),
                SizedBox(width: 10),
                _buildSubscriptionOption(
                    AppLocalizations.of(context)!.annual_sub),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildUpgradeCard(
                        AppLocalizations.of(context)!.platinum_acco,
                        Colors.purple,
                        [
                          {
                            "text":
                                AppLocalizations.of(context)!.feature_your_page,
                            "icon": AppImages.UpgradeProfile
                          },
                          {
                            "text":
                                AppLocalizations.of(context)!.promote_your_ads,
                            "icon": AppImages.ad2
                          },
                          {
                            "text": AppLocalizations.of(context)!.remove_ads,
                            "icon": AppImages.ad
                          },
                        ],
                        textColor: Colors.white),
                    _buildUpgradeCard(AppLocalizations.of(context)!.gold_acco,
                        AppColors.primaryGold, [
                      {
                        "text": AppLocalizations.of(context)!.feature_your_page,
                        "icon": AppImages.UpgradeProfile
                      },
                      {
                        "text": AppLocalizations.of(context)!.promote_your_ads,
                        "icon": AppImages.ad
                      },
                    ]),
                    _buildUpgradeCard(
                        AppLocalizations.of(context)!.silver_acco,
                        Colors.white,
                        [
                          {
                            "text":
                                AppLocalizations.of(context)!.feature_your_page,
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

  Widget _buildSubscriptionOption(String type) {
    bool isSelected = subscriptionType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          subscriptionType = type;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGold : Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildUpgradeCard(
      String title, Color color, List<Map<String, String>> features,
      {Color textColor = Colors.black}) {
    bool isSelected = selectedPlan == title;

    int price = subscriptionType == AppLocalizations.of(context)!.annual_sub
        ? (yearlyPrices[title] ?? 0)
        : (monthlyPrices[title] ?? 0);

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
                    Image.asset(
                      feature["icon"]!,
                      width: 25,
                      height: 25,
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
              Text(AppLocalizations.of(context)!.choose_payment,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.InstaPay, width: 40),
                  SizedBox(width: 10),
                  Image.asset(AppImages.vodafonCash, width: 40),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(AppLocalizations.of(context)!.subscribe_now),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
