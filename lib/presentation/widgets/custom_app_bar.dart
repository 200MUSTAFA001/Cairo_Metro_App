import 'package:cairo_metro_guide_app/presentation/screens/metro_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget? customAppBar() {
  return AppBar(
    leading: Transform.scale(
        scale: 0.8, child: Image.asset("assets/logo/appLogo.png")),
    title: const Text("Cairo Metro"),
    backgroundColor: Colors.red[800],
    foregroundColor: Colors.white,
    actions: [
      IconButton(
          onPressed: () {
            Get.to(const MetroMap());
          },
          icon: const Icon(CupertinoIcons.map)),
    ],
  );
}
