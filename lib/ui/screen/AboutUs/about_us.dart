import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = '/about-us';

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

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
            Text(
              AppLocalizations.of(context)!.who_we_are,
              style: TextStyle(
                color: AppColors.primaryGold,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.white24),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.about_one,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.about_two,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.about_three,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.about_four,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.about_five,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 1.6,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:
                      const Icon(Icons.facebook, color: Colors.white, size: 30),
                  onPressed: () =>
                      _launchURL("https://www.facebook.com/YOUR_PAGE"),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.mail, color: Colors.white, size: 30),
                  onPressed: () => _launchURL("mailto:your_email@gmail.com"),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.ondemand_video,
                      color: Colors.white, size: 30),
                  onPressed: () => _launchURL(
                      "https://www.youtube.com/channel/YOUR_CHANNEL_ID"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
