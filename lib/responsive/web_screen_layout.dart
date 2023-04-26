import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinsta/models/user_model.dart';
import 'package:myinsta/providers/user_provider.dart';
import 'package:myinsta/utils/global_variables.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _pageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int value) {
    pageController.jumpToPage(value);
    setState(() {
      _pageIndex = value;
    });
  }

  void onPageChanged(int value) {
    setState(() {
      _pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // getting user data from provider
    UserModel user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: SvgPicture.asset(
            'assets/instagram.svg',
            height: 36,
            colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
          ),
          actions: [
            IconButton(
              onPressed: () => navigationTapped(0),
              color: _pageIndex == 0 ? primaryColor : secondaryColor,
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () => navigationTapped(1),
              color: _pageIndex == 1 ? primaryColor : secondaryColor,
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () => navigationTapped(2),
              color: _pageIndex == 2 ? primaryColor : secondaryColor,
              icon: const Icon(Icons.add_a_photo),
            ),
            IconButton(
              onPressed: () => navigationTapped(3),
              color: _pageIndex == 3 ? primaryColor : secondaryColor,
              icon: const Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () => navigationTapped(4),
              icon: const Icon(Icons.person),
              color: _pageIndex == 4 ? primaryColor : secondaryColor,
            ),
          ],
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: homeScreenItems,
        ));
  }
}
