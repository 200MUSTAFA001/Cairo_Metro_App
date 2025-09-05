import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/location_model.dart';

class LocationsList extends StatelessWidget {
  const LocationsList({
    super.key,
    required this.addressesList,
    required this.address,
    required this.onChangedBool,
  });

  final RxList<LocationModel> addressesList;
  final void Function(LocationModel) address;
  final void Function(bool) onChangedBool;

  List<LocationModel> filteredList() {
    final filteredList = addressesList
        .where((address) =>
            address.address.state == "القاهرة" ||
            address.address.state == "القليوبية" ||
            address.address.state == "الجيزة")
        .toList();
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return filteredList().isEmpty
          ? const SliverFillRemaining(
              child: Center(
                child: Text("no date found"),
              ),
            )
          : SliverList.builder(
              itemCount: filteredList().length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      address(filteredList()[index]);
                      onChangedBool(true);
                    },
                    title: Text(filteredList()[index].address.name),
                    subtitle: Text(filteredList()[index].displayName),
                  ),
                ),
              ),
            );
    });
  }
}
