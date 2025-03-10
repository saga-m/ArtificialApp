import 'package:artificial/assets.dart';
import 'package:artificial/ui/screen/Home/home_screen.dart';
import 'package:artificial/ui/screen/widget/custom_buttom.dart';
import 'package:artificial/ui/screen/widget/custom_textFiled.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final Function(bool) onToggle;

  LoginForm({required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "🔑 تسجيل الدخول",
              style: TextStyle(
                  color: AppColors.primaryGold,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CustomTextField(label: "👤 الاسم"),
            CustomTextField(
                label: "📞 رقم الهاتف", keyboardType: TextInputType.phone),
            SizedBox(height: 16),
            CustomButton(
              text: "تسجيل الدخول",
              fontSize: 25,
              onPressed: () {
                print("تم تسجيل الدخول");
              },
              backgroundColor: AppColors.primaryGold,
              textColor: Colors.black,
            ),
            TextButton(
              onPressed: () => onToggle(false),
              child: Text("ليس لديك حساب؟ سجل الآن"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: Text("  استخدم التطبيق  "),
            ),
          ],
        ),
      ),
    );
  }
}
