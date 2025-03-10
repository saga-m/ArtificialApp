import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = '/about-us';

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
              "من نحن",
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.white24),
            const SizedBox(height: 10),
            const Text(
              "نحن في تطبيق صنايعي نسعى إلى تبسيط حياتك اليومية من خلال توفير منصة تجمع بين العملاء وأمهر الحرفيين والصنايعية في مكان واحد.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "هدفنا هو تسهيل الوصول إلى خدمات الصيانة والإصلاح والتجديد بكل سرعة وسهولة، حيث يمكنك العثور على الصنايعي المناسب في الوقت والمكان الذي تحتاج إليه، بضغطة زر.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "صنايعي هو الحل الأمثل لكل من يبحث عن الجودة والاحترافية في التعامل، مع نظام تقييم ومراجعات يضمن لك الثقة والشفافية.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "نحن ملتزمون بتقديم تجربة استثنائية تجعل التواصل بين العميل والصنايعي أسرع وأكثر كفاءة من أي وقت مضى.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "انضم إلينا الآن ووعدنا نساعدك على إنجاز كل ما تحتاجه بسهولة!",
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
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.mail, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
