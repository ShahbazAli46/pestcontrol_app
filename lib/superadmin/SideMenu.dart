// lib/components/generic/SideMenu.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/AppImages.dart';
import '../../utils/TextStyle.dart';
import '../../utils/appColors.dart';
import '../../utils/AlertService.dart';
import '../../user/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuItem {
  final String title;
  final String icon;
  final Widget screen;

  MenuItem(this.title, this.icon, this.screen);
}

class SideMenu extends StatelessWidget {
  final List<MenuItem> menuItems;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SideMenu({
    Key? key,
    required this.menuItems,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Logo/Header Area
            // Menu Items
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return _buildMenuItem(index, context);
                },
              ),
            ),
            // Logout Button
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(int index, context) {
    final item = menuItems[index];
    final isSelected = selectedIndex == index;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? AppColors.appGreen.withOpacity(0.1) : Colors.transparent,
      ),
      child: ListTile(
        leading: Image.asset(
          item.icon,
          height: 24,
          color: isSelected ? AppColors.appGreen : Colors.grey,
        ),
        title: AppTextLabels.boldTextShort(
          label: item.title,
          fontSize: 14,
          color: isSelected ? AppColors.appGreen : Colors.grey,
        ),
        onTap: ()  {
          Scaffold.of(context).closeDrawer();
          onItemSelected(index);
        },
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListTile(
        leading: Image.asset(
          AppImages.logout,
          height: 24,
          color: Colors.red,
        ),
        title: AppTextLabels.boldTextShort(
          label: "Logout",
          fontSize: 14,
          color: Colors.red,
        ),
        onTap: () {
          AlertService.showAlertWithAction(
            "Alert",
            "Are you sure you want to logout?",
            onOkPressed: _handleLogout,
          );
        },
      ),
    );
  }

  void _handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(() => Login());
  }
}