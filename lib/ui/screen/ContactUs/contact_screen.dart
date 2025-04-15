import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactScreen extends StatelessWidget {
  static const String routeName = '/contact_us';

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
              AppLocalizations.of(context)!.conuct_us,
              style: TextStyle(
                color: AppColors.primaryGold,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              title: AppLocalizations.of(context)!.you_tube,
              imagePath: AppImages.you_tube,
              subtitle: "YouTube",
              onTap: () =>
                  _launchURL("https://www.youtube.com/channel/YOUR_CHANNEL_ID"),
            ),
            _buildContactItem(
              title: AppLocalizations.of(context)!.whats_app,
              imagePath: AppImages.whatsapp,
              subtitle: "+01002003536\nWhatsApp",
              onTap: () => _launchURL("https://wa.me/201002003536"),
            ),
            _buildContactItem(
              title: AppLocalizations.of(context)!.facebook,
              imagePath: AppImages.Facebook,
              subtitle: "Facebook_page",
              onTap: () => _launchURL("https://www.facebook.com/YOUR_PAGE"),
            ),
            _buildContactItem(
              title: AppLocalizations.of(context)!.gmail,
              imagePath: AppImages.gmail,
              subtitle: "Gmail",
              onTap: () => _launchURL("mailto:your_email@gmail.com"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required String title,
    required String imagePath,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        const Divider(color: Colors.white24),
        InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 30, height: 30),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
