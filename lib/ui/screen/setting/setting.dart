import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:artificial/ui/screen/widget/languages_switch.dart';
import 'package:artificial/ui/screen/Profile/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = '/setting';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // زر تغيير اللغة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.change_language,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const LanguageSwitcher(),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // زر الانتقال للملف الشخصي
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.person, color: AppColors.primaryGold),
              title: Text(
                AppLocalizations.of(context)!.profile,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
