import 'package:cairo_metro_guide_app/presentation/widgets/second_page_widgets/not_selected_address.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../data/logic/functions.dart';
import '../../data/models/location_model.dart';
import '../../data/services/address_service.dart';
import '../widgets/second_page_widgets/locations_list.dart';
import '../widgets/second_page_widgets/selected_address_card.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final featureInput = TextEditingController();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 400));

  final onChangedBool = false.obs;

  final addressesList = <LocationModel>[].obs;

  final address = Rxn<LocationModel>();

  Future<void> getLocation(String location) async {
    debouncer(() async {
      final service = LocationService();
      final result = await service.getSimilarLocation(location);
      addressesList.assignAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 8, top: 12, right: 4),
              child: Text(
                "This Feature Allows You To know The Nearest Station To Your Arrival Point",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
          Obx(() {
            if (address.value != null) {
              return SelectedAddressCard(address: address);
            } else {
              return const NotSelectedAddress();
            }
          }),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 12, bottom: 12),
                  child: Row(
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        child: TextField(
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          controller: featureInput,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Please Enter Your Arrival Point",
                            suffix: IconButton(
                              onPressed: () {
                                onChangedBool.value = false;
                                featureInput.clear();
                                address.value = null;
                                addressesList.clear();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) getLocation(value);
                          },
                        ),
                      ),
                      Obx(() {
                        return ElevatedButton(
                          onPressed: onChangedBool.value == true
                              ? () {
                                  getNearestStationByArrivalPoint(
                                    latitude: address.value!.lat.toDouble(),
                                    longitude: address.value!.lon.toDouble(),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                          ),
                          child: const Text(
                            "Start",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Addresses list",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          LocationsList(
              addressesList: addressesList,
              address: (value) {
                address.value = value;
              },
              onChangedBool: (value) {
                onChangedBool.value = value;
              }),
        ],
      ),
    );
  }
}
