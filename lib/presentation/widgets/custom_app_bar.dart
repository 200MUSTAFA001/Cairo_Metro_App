import 'package:flutter/material.dart';

PreferredSizeWidget? customAppBar() {
  return AppBar(
    leading: Transform.scale(
        scale: 0.8, child: Image.asset("assets/logo/appLogo.png")),
    title: const Text("Cairo Metro"),
    backgroundColor: Colors.red[800],
    foregroundColor: Colors.white,
  );
}
