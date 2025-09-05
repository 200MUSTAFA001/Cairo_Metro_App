import 'package:cairo_metro_guide_app/presentation/screens/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_app_bar.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController controller = PageController();

  final currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (value) {
            currentIndex.value = value;
            controller.jumpToPage(currentIndex.value);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
              activeIcon: Icon(CupertinoIcons.house_fill),
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search), label: "Search"),
          ],
        );
      }),
      body: PageView(
        controller: controller,
        onPageChanged: (value) {
          currentIndex.value = value;
        },
        children: const [
          HomePage(),
          SecondPage(),
        ],
      ),
    );
  }
}
