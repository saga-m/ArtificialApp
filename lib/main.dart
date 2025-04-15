import 'package:artificial/ui/screen/AboutUs/about_us.dart';
import 'package:artificial/ui/screen/ContactUs/contact_screen.dart';
import 'package:artificial/ui/screen/Fav/fav_screen.dart';
import 'package:artificial/ui/screen/Home/home_screen.dart';
import 'package:artificial/ui/screen/Intro/intro_screen.dart';
import 'package:artificial/ui/screen/Upgrade/upgrade_screen.dart';
import 'package:artificial/ui/screen/profile/profile_screen.dart';
import 'package:artificial/ui/screen/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:artificial/ui/screen/Fav/Favorites_Provider.dart';
import 'package:artificial/ui/screen/widget/languages_provider.dart';
import 'package:artificial/ui/screen/Splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(
            create: (context) => LanguageProvider()), // ✅ تأكدي إنه هنا
      ],
      child: const Artificial(), // ✅ Artificial تحت MultiProvider
    ),
  );
}

class Artificial extends StatelessWidget {
  const Artificial({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          title: 'صنايعى',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
            useMaterial3: true,
          ),
          locale: languageProvider.currentLocale, // ✅ Keep only this one

          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
          ],

          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            IntroScreen.routeName: (context) => IntroScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            UpgradeScreen.routeName: (context) => UpgradeScreen(),
            ContactScreen.routeName: (context) => ContactScreen(),
            AboutUsScreen.routeName: (context) => AboutUsScreen(),
            FavScreen.routeName: (context) => FavScreen(),
            SettingScreen.routeName: (context) => SettingScreen(),
          },
        );
      },
    );
  }
}
