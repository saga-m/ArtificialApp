import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff40403D),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.only(top: 5),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xffffda1a),
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        items: [
          _buildNavItem(
              icon: Icons.home,
              label: AppLocalizations.of(context)!.home,
              isSelected: currentIndex == 0),
          _buildNavItemWithImage(
              imagePath: AppImages.Detals,
              label: AppLocalizations.of(context)!.detailed_requests,
              isSelected: currentIndex == 1),
          _buildNavItem(
              icon: Icons.chat,
              label: AppLocalizations.of(context)!.chats,
              isSelected: currentIndex == 2),
          _buildNavItem(
              icon: Icons.person,
              label: AppLocalizations.of(context)!.profile,
              isSelected: currentIndex == 3),
          _buildNavItem(
              icon: Icons.calendar_today,
              label: AppLocalizations.of(context)!.calender,
              isSelected: currentIndex == 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffffda1a) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Color(0xffffda1a),
          size: 30,
        ),
      ),
      label: label,
    );
  }

  BottomNavigationBarItem _buildNavItemWithImage({
    required String imagePath,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffffda1a) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          imagePath,
          width: 30,
          height: 30,
          color: isSelected ? Colors.black : Color(0xffffda1a),
        ),
      ),
      label: label,
    );
  }
}
