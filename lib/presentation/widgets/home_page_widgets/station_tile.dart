import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StationTile extends StatelessWidget {
  const StationTile({
    super.key,
    required this.route2,
    required this.route1,
    required this.index,
  });

  final RxList route2;
  final RxList route1;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isLast: index == route2.length - 1,
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
            "${index + route1.length}",
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
        route2[index],
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ).paddingOnly(bottom: 10, top: 10, left: 10),
    );
  }
}
