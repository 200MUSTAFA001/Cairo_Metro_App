import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Route1List extends StatelessWidget {
  const Route1List({
    super.key,
    required this.route1,
    required this.route2,
  });

  final RxList route1;
  final RxList route2;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SliverPadding(
        padding: const EdgeInsets.only(left: 20, top: 8),
        sliver: SliverList.builder(
          itemCount: route2.isNotEmpty ? route1.length - 1 : route1.length,
          itemBuilder: (context, index) => TimelineTile(
            isFirst: index == 0,
            isLast: index == route1.length - 1 && route2.isEmpty,
            indicatorStyle: IndicatorStyle(
              width: context.width * 0.1,
              height: context.height * 0.035,
              indicator: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.green,
              thickness: 5,
            ),
            afterLineStyle: const LineStyle(
              color: Colors.green,
              thickness: 5,
            ),
            endChild: Text(
              route1[index],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ).paddingOnly(bottom: 10, left: 10, top: 10),
          ),
        ),
      );
    });
  }
}
