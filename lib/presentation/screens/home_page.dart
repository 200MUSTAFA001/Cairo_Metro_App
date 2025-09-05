import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/logic/calculator_function.dart';
import '../../data/logic/functions.dart';
import '../../data/logic/metro_list.dart';
import '../widgets/home_page_widgets/route1_list.dart';
import '../widgets/home_page_widgets/route2_list.dart';
import '../widgets/home_page_widgets/trip_info_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final inputStart = TextEditingController();
  final inputEnd = TextEditingController();
  final featureInput = TextEditingController();

  final start = "".obs;
  final end = "".obs;

  final count = 0.obs;
  final price = 0.obs;
  final time = 0.obs;
  final direction = "".obs;
  final route1 = [].obs;
  final route2 = [].obs;
  final spaceBetween = "".obs;

  late final List<DropdownMenuEntry<String>> dropdownEntries;

  @override
  void initState() {
    super.initState();
    dropdownEntries = allLines
        .distinct()
        .map((value) => DropdownMenuEntry(
              value: value,
              label: value,
              style: MenuItemButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
            ))
        .toList();
  }

  void clearAll() {
    inputStart.clear();
    inputEnd.clear();
    route1.value = [];
    route2.value = [];
    count.value = 0;
    price.value = 0;
    time.value = 0;
    direction.value = "";
    spaceBetween.value = "";
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                const Text(
                  "Enter Start Station",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownMenu(
                  dropdownMenuEntries: dropdownEntries,
                  width: 300,
                  enabled: true,
                  enableSearch: true,
                  enableFilter: true,
                  requestFocusOnTap: true,
                  controller: inputStart,
                  hintText: "Please Enter Station",
                  menuHeight: 400,
                ).paddingOnly(right: 20, left: 12),
              ],
            ).paddingOnly(top: 20),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                const Text(
                  "Enter Arrival Station",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                DropdownMenu(
                  dropdownMenuEntries: dropdownEntries,
                  width: 300,
                  enabled: true,
                  enableSearch: true,
                  enableFilter: true,
                  requestFocusOnTap: true,
                  controller: inputEnd,
                  hintText: "Please Enter Station",
                  menuHeight: 400,
                ).paddingOnly(right: 20, left: 12),
              ],
            ).paddingOnly(top: 20, bottom: 20),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.redAccent.shade700),
                  onPressed: () {
                    metroFunction(
                      inputStart: inputStart,
                      inputEnd: inputEnd,
                      count: count,
                      direction: direction,
                      route1: route1,
                      route2: route2,
                      price: price,
                      spaceBetween: spaceBetween,
                    );
                  },
                  label: const Text(
                    "Start",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.directions_bus,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.indigo),
                    onPressed: () {
                      swapStations(inputStart: inputStart, inputEnd: inputEnd);
                      metroFunction(
                        inputStart: inputStart,
                        inputEnd: inputEnd,
                        count: count,
                        direction: direction,
                        route1: route1,
                        route2: route2,
                        price: price,
                        spaceBetween: spaceBetween,
                      );
                    },
                    label: const Text(
                      "Reverse",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.sync_outlined,
                      color: Colors.white,
                    )),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: clearAll,
                    icon: const Icon(Icons.clear),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      getNearestStation();
                    },
                    icon: const Icon(Icons.near_me),
                    label: const Text("Nearest Station")),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    getNearestStationOnMap();
                  },
                  label: const Text("Show On Map"),
                  icon: const Icon(Icons.place),
                )
              ],
            ),
          ),
          TripInfoCards(
            count: count,
            price: price,
            direction: direction,
            spaceBetween: spaceBetween,
          ),
          Route1List(route1: route1, route2: route2),
          Route2List(route2: route2, route1: route1),
        ],
      ),
    );
  }
}
