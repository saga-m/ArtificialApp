import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  static const String routeName = '/contact_us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
            const Text(
              "تواصل معنا",
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              title: "صفحتنا على يوتيوب",
              imagePath: AppImages.you_tube, // صورة يوتيوب
              subtitle: "YouTube",
            ),
            _buildContactItem(
              title: "رقم الواتس اب / خدمة العملاء",
              imagePath: AppImages.whatsapp, // صورة واتساب
              subtitle: "+01002003536\nWhatsApp",
            ),
            _buildContactItem(
              title: "صفحتنا على فيسبوك",
              imagePath: AppImages.Facebook, // صورة فيسبوك
              subtitle: "Facebook_page",
            ),
            _buildContactItem(
              title: "راسلنا على جيميل",
              imagePath: AppImages.gmail, // صورة Gmail
              subtitle: "البريد الوارد",
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
  }) {
    return Column(
      children: [
        const Divider(color: Colors.white24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath,
                width: 30, height: 30), // استبدال Icon بـ Image.asset
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
        const SizedBox(height: 10),
      ],
    );
  }
}
