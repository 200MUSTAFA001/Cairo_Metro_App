import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/location_model.dart';

class SelectedAddressCard extends StatelessWidget {
  const SelectedAddressCard({
    super.key,
    required this.address,
  });

  final Rxn<LocationModel> address;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const Text(
              "Selected Location",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    address.value!.address.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    address.value!.displayName,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
