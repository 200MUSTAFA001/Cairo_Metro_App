import 'package:flutter/material.dart';

class NotSelectedAddress extends StatelessWidget {
  const NotSelectedAddress({super.key});

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
        child: const Column(
          children: [
            Text(
              "Selected Location",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Please select address from list below"),
            ),
          ],
        ),
      ),
    );
  }
}
