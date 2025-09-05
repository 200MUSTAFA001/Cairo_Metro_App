import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_card.dart';

class TripInfoCards extends StatelessWidget {
  const TripInfoCards({
    super.key,
    required this.count,
    required this.price,
    required this.direction,
    required this.spaceBetween,
  });

  final RxInt count;
  final RxInt price;
  final RxString direction;
  final RxString spaceBetween;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Obx(() => CustomCard(
              icon: Icons.directions_bus,
              title: "Stations Count",
              value: "${count.value.abs()} Stations")),
          Obx(() => CustomCard(
              icon: Icons.attach_money,
              title: "Price",
              value: "${price.value} EGP")),
          Obx(() => CustomCard(
              icon: Icons.timer_outlined,
              title: "Arrival Time",
              value: "${count.abs() * 3} Minutes")),
          Obx(() => CustomCard(
              icon: Icons.directions,
              title: "Direction",
              value: direction.value)),
          Obx(() => CustomCard(
              icon: Icons.sync_alt,
              title: "Space Between The Stations",
              value: "$spaceBetween")),
        ],
      ).paddingAll(15),
    );
  }
}
