import 'package:artificial/assets.dart';
import 'package:artificial/ui/screen/Home/home_screen.dart';
import 'package:artificial/ui/screen/widget/custom_buttom.dart';
import 'package:artificial/ui/screen/widget/custom_textFiled.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final Function(bool) onToggle;

  RegisterForm({required this.onToggle});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String? selectedGovernorate;
  String? selectedJob;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "👊 سجل الآن",
              style: TextStyle(
                  color: AppColors.primaryGold,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CustomTextField(label: "👤 الاسم"),
            CustomTextField(
                label: "📞 رقم الهاتف", keyboardType: TextInputType.phone),
            CustomTextField(
              label: "🏙 المحافظة",
              dropdownItems: ["القاهرة", "قنا", "الجيزة", "الوادى الجديد"],
              onChanged: (value) {
                setState(() {
                  selectedGovernorate = value;
                });
              },
            ),
            CustomTextField(
              label: "👷 المهنة",
              dropdownItems: ["نجار", "سباك", "كهربائي", "حداد"],
              onChanged: (value) {
                setState(() {
                  selectedJob = value;
                });
              },
            ),
            SizedBox(height: 16),
            CustomButton(
              text: "تسجيل كمستخدم جديد",
              onPressed: () {
                print("تم تسجيل المستخدم");
              },
              backgroundColor: AppColors.primaryGold,
              textColor: Colors.black,
            ),
            TextButton(
              onPressed: () => widget.onToggle(true),
              child: Text("لديك حساب بالفعل؟ تسجيل الدخول"),
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
