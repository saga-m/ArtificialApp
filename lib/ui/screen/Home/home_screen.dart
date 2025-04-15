import 'package:artificial/assets.dart';
import 'package:artificial/ui/Tap/Calender/calender_tap.dart';
import 'package:artificial/ui/Tap/Chat/chat_tap.dart';
import 'package:artificial/ui/Tap/Detals/detals_tap.dart';
import 'package:artificial/ui/Tap/Home/home_tap.dart';
import 'package:artificial/ui/screen/Order/order_card.dart';
import 'package:artificial/ui/Tap/Profile/profile_tap.dart';
import 'package:artificial/ui/screen/AboutUs/about_us.dart';
import 'package:artificial/ui/screen/ContactUs/contact_screen.dart';
import 'package:artificial/ui/screen/Fav/fav_screen.dart';
import 'package:artificial/ui/screen/Upgrade/upgrade_screen.dart';
import 'package:artificial/ui/screen/profile/profile_screen.dart';
import 'package:artificial/ui/screen/setting/setting.dart';
import 'package:artificial/ui/screen/widget/SearchResultsScreen.dart';
import 'package:artificial/ui/screen/widget/custom_search.dart';
import 'package:artificial/ui/screen/widget/navigation_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  bool isSearching = false;
  final int? initialTabIndex;
  HomeScreen({this.initialTabIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int selectedIndex = 0;
  Map<String, dynamic>? selectedWorker;
  late TextEditingController searchController;

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      setState(() {
        isSearching = searchController.text.isNotEmpty;
      });
    });
    if (widget.initialTabIndex != null) {
      selectedIndex = widget.initialTabIndex!;
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void openSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchResultsScreen(
                query: searchController.text,
              )),
    );
  }

  void openOrderCard(Map<String, dynamic> worker) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderCard(workerData: worker)),
    );

    if (result != null) {
      if (result is Map<String, dynamic> && result.containsKey("tabIndex")) {
        setState(() {
          selectedIndex = result["tabIndex"];
        });
      } else if (result is Map<String, dynamic>) {
        setState(() {
          selectedWorker = result;
          selectedIndex = 2; // ← ده مهم يوديك على ChatTap
        });
      }
    }
  }

  void onTabChange(int index) {
    setState(() {
      selectedIndex = index;
      isSearching = false;
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
      ChatTap(
        workerName: selectedWorker?["name"] ?? "بدون اسم",
        workerImage: selectedWorker?["image"] ?? AppImages.User,
      ),
      ProfileTap(workerData: selectedWorker),
      CalenderTap(),
    ];

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
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
                        setState(() {
                          isSearching = query.isNotEmpty;
                        });
                      },
                    ),
                  ),
                const SizedBox(height: 50),
                Expanded(
                  child: isSearching
                      ? SearchResultsScreen(query: searchController.text)
                      : _getSelectedScreen(),
                ),
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

  Widget _getSelectedScreen() {
    List<Widget> tabs = [
      HomeTap(onTabChanged: onTabChange, onWorkerSelected: openOrderCard),
      DetalsTap(),
      ChatTap(
        workerName: selectedWorker?["name"] ?? "No Name",
        workerImage: selectedWorker?["image"] ?? AppImages.work,
      ),
      ProfileTap(workerData: selectedWorker),
      CalenderTap(),
    ];
    return tabs[selectedIndex];
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
                _drawerItem(Icons.workspace_premium,
                    AppLocalizations.of(context)!.upgrade_account, () {
                  Navigator.pushNamed(context, UpgradeScreen.routeName);
                }),
                _drawerItem(
                    Icons.favorite, AppLocalizations.of(context)!.favorites,
                    () {
                  Navigator.pushNamed(context, FavScreen.routeName);
                }),
                _drawerItem(
                    Icons.phone, AppLocalizations.of(context)!.conuct_us, () {
                  Navigator.pushNamed(context, ContactScreen.routeName);
                }),
                _drawerItem(Icons.info, AppLocalizations.of(context)!.about_us,
                    () {
                  Navigator.pushNamed(context, AboutUsScreen.routeName);
                }),
                _drawerItem(
                    Icons.settings, AppLocalizations.of(context)!.settings, () {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                }),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook, color: Colors.white, size: 30),
                  onPressed: () {
                    _launchURL("https://www.facebook.com/");
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.mail, color: Colors.white, size: 30),
                  onPressed: () {
                    _launchURL("mailto:something@gmail.com");
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon:
                      Icon(Icons.ondemand_video, color: Colors.white, size: 30),
                  onPressed: () {
                    _launchURL("https://www.youtube.com/");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
      onTap: onTap,
    );
  }
}
