import 'package:artificial/l10n/app_translation.dart';
import 'package:artificial/ui/screen/Home/home_screen.dart';
import 'package:artificial/ui/screen/Intro/login_form.dart';
import 'package:artificial/ui/screen/Intro/register_form.dart';
import 'package:artificial/ui/screen/widget/custom_buttom.dart';
import 'package:artificial/ui/screen/widget/languages_switch.dart';
import 'package:flutter/material.dart';
import 'package:artificial/assets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = '/intro';

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool showForm = false;
  bool showLoginForm = false;
  bool showUserTypeChoice = false;
  String userType = "";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

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
                              : RegisterForm(
                                  onToggle: toggleForm, userType: userType))
                          : showUserTypeChoice
                              ? _buildUserTypeButtons(screenWidth, screenHeight)
                              : _buildButtons(screenWidth, screenHeight),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtons(double screenWidth, double screenHeight) {
    double buttonFontSize = screenWidth * 0.05;
    double buttonSpacing = screenHeight * 0.02;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          text: AppLocalizations.of(context)!.register,
          fontSize: buttonFontSize,
          textColor: AppColors.primaryGold,
          onPressed: () {
            setState(() {
              showForm = false;
              showUserTypeChoice = true;
            });
          },
        ),
        SizedBox(height: buttonSpacing),
        CustomButton(
          text: AppLocalizations.of(context)!.use_app,
          fontSize: buttonFontSize,
          textColor: AppColors.primaryGold,
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
        ),
        SizedBox(height: buttonSpacing),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black,
          ),
          child: LanguageSwitcher(),
        ),
      ],
    );
  }

  Widget _buildUserTypeButtons(double screenWidth, double screenHeight) {
    double buttonFontSize = screenWidth * 0.05;
    double buttonSpacing = screenHeight * 0.02;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          text: AppLocalizations.of(context)!.technician,
          fontSize: buttonFontSize,
          textColor: AppColors.primaryGold,
          onPressed: () {
            setState(() {
              userType = "worker";
              showForm = true;
              showLoginForm = false;
              showUserTypeChoice = false;
            });
          },
        ),
        SizedBox(height: buttonSpacing),
        CustomButton(
          text: AppLocalizations.of(context)!.normal_user,
          fontSize: buttonFontSize,
          textColor: AppColors.primaryGold,
          onPressed: () {
            setState(() {
              userType = "normal";
              showForm = true;
              showLoginForm = false;
              showUserTypeChoice = false;
            });
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
