import 'package:artificial/assets.dart';
import 'package:artificial/ui/Tab/Calender/calender_tap.dart';
import 'package:artificial/ui/Tab/Chat/chat_tap.dart';
import 'package:artificial/ui/Tab/Detals/detals_tap.dart';
import 'package:artificial/ui/Tab/Home/home_tap.dart';
import 'package:artificial/ui/Tab/Home/order_card.dart';
import 'package:artificial/ui/Tab/Profile/profile_tap.dart';
import 'package:artificial/ui/screen/AboutUs/about_us.dart';
import 'package:artificial/ui/screen/ContactUs/contact_screen.dart';
import 'package:artificial/ui/screen/Upgrade/upgrade_screen.dart';
import 'package:artificial/ui/screen/profile/profile_screen.dart';
import 'package:artificial/ui/screen/widget/custom_search.dart';
import 'package:artificial/ui/screen/widget/navigation_buttom.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int selectedIndex = 0;
  Map<String, dynamic>? selectedWorker;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void openOrderCard(Map<String, dynamic> worker) async {
    final selectedWorker = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderCard(workerData: worker)),
    );

    if (selectedWorker != null) {
      setState(() {
        this.selectedWorker = selectedWorker;
        selectedIndex = 4;
      });
    }
  }

  void selectWorker(Map<String, dynamic> worker) {
    setState(() {
      selectedWorker = worker;
      selectedIndex = 4;
    });
  }

  void onTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      HomeTap(
        onTabChanged: onTabChange,
        onWorkerSelected: openOrderCard,
      ),
      DetalsTap(),
      ChatTap(),
      ProfileTap(workerData: selectedWorker),
      CalenderTap(),
    ];

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              icon: Image.asset(
                AppImages.User,
                width: 40,
                height: 40,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                AppImages.More,
                width: 30,
                height: 30,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
        endDrawer: _buildDrawer(),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages.HomeScreen,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                if (selectedIndex == 0)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 140, left: 20, right: 150),
                    child: CustomSearchBar(
                      controller: searchController,
                      onSearch: (query) {
                        print("تم البحث عن: $query");
                      },
                    ),
                  ),
                const SizedBox(height: 50),
                Expanded(child: tabs[selectedIndex]),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNav(
          currentIndex: selectedIndex,
          onTap: onTabChange,
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: AppColors.primaryGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _drawerItem(Icons.workspace_premium, "ترقيه الحساب", () {
                  Navigator.pushNamed(context, UpgradeScreen.routeName);
                }),
                _drawerItem(Icons.favorite, "المفضله", () {}),
                _drawerItem(Icons.phone, "تواصل معانا", () {
                  Navigator.pushNamed(context, ContactScreen.routeName);
                }),
                _drawerItem(Icons.info, "عنا", () {
                  Navigator.pushNamed(context, AboutUsScreen.routeName);
                }),
                _drawerItem(Icons.settings, "الإعدادات", () {}),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _socialButton(icon: Icons.mail),
                _socialButton(icon: Icons.facebook),
                _socialButton(imagePath: "assets/icon/youtube.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 10),
            Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _socialButton({IconData? icon, String? imagePath}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
      ),
      child: imagePath != null
          ? Image.asset(imagePath, width: 24, height: 24)
          : Icon(icon, color: Colors.white, size: 24),
    );
  }
}
