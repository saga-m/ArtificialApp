import 'package:artificial/ui/screen/Home/home_screen.dart';
import 'package:artificial/ui/screen/Intro/login_form.dart';
import 'package:artificial/ui/screen/Intro/register_form.dart';
import 'package:artificial/ui/screen/widget/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:artificial/assets.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = '/intro';

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool showForm = false;
  bool showLoginForm = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages.intro,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: showForm
                      ? (showLoginForm
                          ? LoginForm(onToggle: toggleForm)
                          : RegisterForm(onToggle: toggleForm))
                      : _buildButtons(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          text: "👊 سجل الآن",
          fontSize: 30,
          textColor: AppColors.primaryGold,
          onPressed: () {
            setState(() {
              showForm = true;
              showLoginForm = false;
            });
          },
        ),
        SizedBox(height: 16),
        CustomButton(
          text: "استخدم التطبيق",
          fontSize: 30,
          textColor: AppColors.primaryGold,
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
        ),
      ],
    );
  }

  void toggleForm(bool isLogin) {
    setState(() {
      showForm = true;
      showLoginForm = isLogin;
    });
  }
}
