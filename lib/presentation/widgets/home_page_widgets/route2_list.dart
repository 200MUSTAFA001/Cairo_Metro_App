import 'package:cairo_metro_guide_app/presentation/widgets/home_page_widgets/station_tile.dart';
import 'package:cairo_metro_guide_app/presentation/widgets/home_page_widgets/transition_station_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Route2List extends StatelessWidget {
  const Route2List({
    super.key,
    required this.route2,
    required this.route1,
  });

  final RxList route2;
  final RxList route1;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SliverPadding(
        padding: const EdgeInsets.only(left: 20, bottom: 20),
        sliver: SliverList.builder(
          itemCount: route2.length,
          itemBuilder: (context, index) => index == 0
              ? TransitionStationTile(
                  route2: route2,
                  route1: route1,
                  index: index,
                )
              : StationTile(
                  route2: route2,
                  route1: route1,
                  index: index,
                ),
        ),
      );
    });
  }
}
