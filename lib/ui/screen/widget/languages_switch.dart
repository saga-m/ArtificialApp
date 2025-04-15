import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:artificial/ui/screen/widget/languages_provider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return AnimatedToggleSwitch<String>.rolling(
        current: languageProvider.currentLocale.languageCode,
        values: ["ar", "en"],
        style: ToggleStyle(
          backgroundColor: Colors.transparent,
          indicatorColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
        ),
        onChanged: (newLocale) {
          languageProvider.changeLocale(newLocale);
        },
        iconBuilder: (value, foreground) {
          if (value == "ar") {
            return CountryFlag.fromCountryCode('EG', height: 30, width: 40);
          } else {
            return CountryFlag.fromCountryCode('GB', height: 30, width: 40);
          }
        });
  }
}
