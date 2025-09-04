import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/location_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width * 1,
          height: MediaQuery.sizeOf(context).height * 1,
          child: ListView.builder(
              itemCount: addressesList.length,
              itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      address(addressesList[index]);
                      onChangedBool(true);
                    },
                    title: Text(addressesList[index].address.name),
                    subtitle: Text(addressesList[index].displayName),
                  )),
        );
      }),
    );
  }
}
