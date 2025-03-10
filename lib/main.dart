import 'package:artificial/assets.dart';
import 'package:artificial/ui/screen/AboutUs/about_us.dart';
import 'package:artificial/ui/screen/ContactUs/contact_screen.dart';
import 'package:artificial/ui/screen/Home/home_screen.dart';
import 'package:artificial/ui/screen/Intro/intro_screen.dart';
import 'package:artificial/ui/screen/Splash/splash_screen.dart';
import 'package:artificial/ui/screen/Upgrade/upgrade_screen.dart';
import 'package:artificial/ui/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Artificial());
}

class Artificial extends StatelessWidget {
  const Artificial({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صنايعى',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryGold),
        cardTheme: CardTheme(
            color: AppColors.primaryBlack,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        IntroScreen.routeName: (context) => IntroScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        UpgradeScreen.routeName: (context) => UpgradeScreen(),
        ContactScreen.routeName: (context) => ContactScreen(),
        AboutUsScreen.routeName: (context) => AboutUsScreen(),
      },
    );
  }
}
