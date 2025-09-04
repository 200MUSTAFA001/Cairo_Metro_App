import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/logic/calculator_function.dart';
import '../../data/logic/functions.dart';
import '../../data/logic/metro_list.dart';
import '../widgets/custom_card.dart';

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
  final state = true.obs;

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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Enter Start Station",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ))
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 20),
                    child: DropdownMenu(
                      dropdownMenuEntries: dropdownEntries,
                      width: 300,
                      enabled: state.value,
                      enableSearch: true,
                      enableFilter: true,
                      requestFocusOnTap: true,
                      controller: inputStart,
                      hintText: "Please Enter Station",
                      menuHeight: 400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Arrival Station",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 12, right: 20),
                  child: DropdownMenu(
                    dropdownMenuEntries: dropdownEntries,
                    width: 300,
                    enabled: state.value,
                    enableSearch: true,
                    enableFilter: true,
                    requestFocusOnTap: true,
                    controller: inputEnd,
                    hintText: "Please Enter Station",
                    menuHeight: 400,
                  )),
            ],
          ),
          const SizedBox(height: 20),
          Row(
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
                  onPressed: () {
                    inputStart.clear();
                    inputEnd.clear();
                    route1.value = [];
                    route2.value = [];
                    count.value = 0;
                    price.value = 0;
                    time.value = 0;
                    direction.value = "";
                    spaceBetween.value = "";
                  },
                  icon: const Icon(Icons.clear),
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
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
          Padding(
            padding: const EdgeInsets.all(15),
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
                Obx(() => CustomCard(
                    icon: Icons.route,
                    title: "Route",
                    value: route1.join(" // "))),
                Obx(() => CustomCard(
                    icon: Icons.route,
                    title: "Route",
                    value: route2.join(" // "))),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
