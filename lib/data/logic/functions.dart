import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:metro_oop/data/models/station_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'metro_list.dart';

locationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Get.snackbar("error", 'Location services are disabled.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Get.snackbar("error", 'Location permissions are denied',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
  if (permission == LocationPermission.deniedForever) {
    Get.snackbar("error",
        'Location permissions are permanently denied, we cannot request permissions.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
}

void getNearestStationByArrivalPoint(
    {required double latitude, required double longitude}) async {
  final stationsList = <Station>[];

  for (var value in allStationsList) {
    final theDistance = Geolocator.distanceBetween(
        latitude, longitude, value.latitude, value.longitude);

    stationsList.add(
      Station(
        stationName: value.stationName,
        latitude: value.latitude,
        longitude: value.longitude,
        distance: theDistance,
      ),
    );
  }

  final theNearest = stationsList.minBy((value) => value.distance);

  if (theNearest != null) {
    Get.defaultDialog(
      title: "The Nearest Station",
      titleStyle: const TextStyle(fontSize: 22),
      content: Text(
        "${theNearest.stationName} Station",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
      confirm: OutlinedButton(
          onPressed: () {
            final uri = Uri.parse(
                "https://www.google.com/maps/dir/?api=1&origin=${theNearest.latitude},${theNearest.longitude}&destination=$latitude,$longitude");
            launchUrl(uri);
          },
          child: const Text("Show on map")),
      cancel: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.red,
        ),
      ),
    );
  }
}

void getNearestStation() async {
  ////
  locationPermission();
  ////
  final myPosition = await Geolocator.getCurrentPosition();
  final stationsList = <Station>[];
  ////
  final allLines = <Station>[];
  allLines.addAll(line1class);
  allLines.addAll(line2class);
  allLines.addAll(line3class);
  allLines.addAll(line3branchclass);
  ////
  for (Station value in allLines) {
    final theDistance = Geolocator.distanceBetween(myPosition.latitude,
        myPosition.longitude, value.latitude, value.longitude);

    stationsList.add(Station(
        stationName: value.stationName,
        latitude: value.latitude,
        longitude: value.longitude,
        distance: theDistance));
  }

  final theNearest = stationsList.minBy((value) => value.distance);

  if (theNearest != null) {
    Get.snackbar(
      "The Nearest Station",
      "( ${theNearest.stationName.capitalizeFirst} ) Station --- With ( ${theNearest.distance.toInt()} ) Metres",
      duration: const Duration(seconds: 10),
      backgroundColor: Colors.blue,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
    );
  }
}

void getNearestStationOnMap() async {
  locationPermission();
  final myPosition = await Geolocator.getCurrentPosition();
  final stationsList = <Station>[];
  ////
  final allLines = <Station>[];
  allLines.addAll(line1class);
  allLines.addAll(line2class);
  allLines.addAll(line3class);
  allLines.addAll(line3branchclass);
  ////
  for (var value in allLines) {
    final theDistance = Geolocator.distanceBetween(
      myPosition.latitude,
      myPosition.longitude,
      value.latitude,
      value.longitude,
    );

    stationsList.add(Station(
        stationName: value.stationName,
        latitude: value.latitude,
        longitude: value.longitude,
        distance: theDistance));
  }

  final theNearest = stationsList.minBy((value) => value.distance);

  if (theNearest != null) {
    final uri = Uri.parse(
        "https://www.google.com/maps/dir/?api=1&origin=${myPosition.latitude},${myPosition.longitude}&destination=${theNearest.latitude},${theNearest.longitude}");
    launchUrl(uri);
  }
}
