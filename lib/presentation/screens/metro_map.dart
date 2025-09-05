import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MetroMap extends StatelessWidget {
  const MetroMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoView(
        maxScale: PhotoViewComputedScale.covered,
        minScale: PhotoViewComputedScale.contained,
        imageProvider: const AssetImage("assets/metro_map/map.jpg"),
      ),
    );
  }
}
