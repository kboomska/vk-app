import 'package:flutter/material.dart';

import 'package:vk_app/domain/factories/screen_factory.dart';
import 'package:vk_app/theme/app_colors.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final _screenFactory = ScreenFactory();
  int _selectedTab = 0;

  static const List<String> _appBarOptions = [
    'Главная',
    'Мессенджер',
    'Настройки',
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        backgroundColor: AppColors.bottomNavigationBackground,
        selectedItemColor: AppColors.bottomNavigationActive,
        unselectedItemColor: AppColors.bottomNavigationInactive,
        selectedFontSize: 12,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: _appBarOptions[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat_bubble_rounded),
            label: _appBarOptions[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.build_rounded),
            label: _appBarOptions[2],
          ),
        ],
        onTap: onSelectTab,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _screenFactory.createNewsFeed(),
          _screenFactory.createChats(),
          Center(child: Text(_appBarOptions[2])),
        ],
      ),
    );
  }
}
