import 'package:artificial/assets.dart';
import 'package:artificial/ui/screen/Home/home_screen.dart';
import 'package:artificial/ui/screen/widget/custom_buttom.dart';
import 'package:artificial/ui/screen/widget/custom_textFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatelessWidget {
  final Function(bool) onToggle;

  LoginForm({required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = constraints.maxWidth * 0.05;
        double fontSize = constraints.maxWidth * 0.05;

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(padding),
            margin: EdgeInsets.symmetric(horizontal: padding),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.login,
                  style: TextStyle(
                      color: AppColors.primaryGold,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                CustomTextField(label: AppLocalizations.of(context)!.name),
                CustomTextField(
                    label: AppLocalizations.of(context)!.phone_number,
                    keyboardType: TextInputType.phone),
                SizedBox(height: 16),
                CustomButton(
                  text: AppLocalizations.of(context)!.login,
                  fontSize: fontSize,
                  onPressed: () {
                    print("تم تسجيل الدخول");
                  },
                  backgroundColor: AppColors.primaryGold,
                  textColor: Colors.black,
                ),
                TextButton(
                  onPressed: () => onToggle(false),
                  child: Text(AppLocalizations.of(context)!.dont_have_account),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  child: Text(AppLocalizations.of(context)!.use_app),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
