import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../models/station_model.dart';
import 'metro_list.dart';

swapStations({required inputStart, required inputEnd}) {
  String temp = inputStart.text;
  inputStart.text = inputEnd.text;
  inputEnd.text = temp;
}

metroFunction({
  required TextEditingController inputStart,
  required TextEditingController inputEnd,
  required RxInt count,
  required RxString direction,
  required RxList route1,
  required RxList route2,
  required RxInt price,
  required RxString spaceBetween,
}) {
  final startField = inputStart.text.toLowerCase();
  final endField = inputEnd.text.toLowerCase();

  final line1StartIndex = line1.indexOf(startField);
  final line2StartIndex = line2.indexOf(startField);
  final line3StartIndex = line3.indexOf(startField);
  int branchStartIndex = line3branch.indexOf(startField);

  final line1EndIndex = line1.indexOf(endField);
  final line2EndIndex = line2.indexOf(endField);
  final line3EndIndex = line3.indexOf(endField);
  int branchEndIndex = line3branch.indexOf(endField);

  final alshohadaaLine1 = line1.indexOf("al shohadaa");
  final alshohadaaLine2 = line2.indexOf("al shohadaa");

  final nasserLine1 = line1.indexOf("nasser");
  final nasserLine3 = line3.indexOf("nasser");

  final attabaLine2 = line2.indexOf("attaba");
  final attabaLine3 = line3.indexOf("attaba");

  final sadatLine1 = line1.indexOf("sadat");
  final sadatLine2 = line2.indexOf("sadat");

  final kitkatLine3 = line3.indexOf("kit kat");

  final cairoUniversityLine2 = line2.indexOf("cairo university");

  if ((startField.isEmpty) || (endField.isEmpty)) {
    count.value = 0;
    direction.value = "";
    route1.value = [];
    Get.snackbar("Error", "Empty Field Please Enter Station",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red);
  } else if (startField == endField) {
    count.value = 0;
    direction.value = "";
    route1.value = [];
    Get.snackbar("Error", "You Entered The Same Station",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red);
  } else if (startField == endField) {
    count.value = 0;
    direction.value = "";
    route1.value = [];
    route2.value = [];
    Get.snackbar("Error", "You Entered The Same Station",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red);
  } else if (line3branch.contains(startField) && line3branch.contains(endField) ||
      line3branch.contains(endField) && line3branch.contains(startField)) {
    count.value = branchEndIndex - branchStartIndex;
    if (count.isNegative) {
      direction.value = "Imbaba";
      route1.value = line3branch
          .sublist(branchEndIndex, branchStartIndex + 1)
          .reversed
          .toList();
      route2.value = [];
    } else {
      direction.value = "Cairo University";
      route1.value = line3branch.sublist(branchStartIndex, branchEndIndex + 1);
      route2.value = [];
    }
  } else if ((startField == "kit kat" && endField == "cairo university") ||
      (startField == "cairo university" && endField == "kit kat")) {
    line3branch.insert(0, "kit kat");
    line3branch.add("cairo university");

    branchStartIndex = line3branch.indexOf("kit kat");
    branchEndIndex = line3branch.indexOf("cairo university");

    count.value = branchEndIndex - branchStartIndex;

    if ((startField == "kit kat" && endField == "cairo university")) {
      route1.value = line3branch.sublist(branchStartIndex, branchEndIndex + 1);
      direction.value = "Cairo University";
      route2.value = [];
    } else if ((startField == "cairo university" && endField == "kit kat")) {
      route1.value = line3branch
          .sublist(branchStartIndex, branchEndIndex + 1)
          .reversed
          .toList();
      route2.value = [];
      direction.value = "Imbaba";
    }
  } else if ((startField == "kit kat" && line3branch.contains(endField)) ||
      line3branch.contains(startField) && (endField == "kit kat")) {
    line3branch.insert(0, "kit kat");

    if ((startField == "kit kat" && line3branch.contains(endField))) {
      branchStartIndex = line3branch.indexOf("kit kat");
      branchEndIndex = line3branch.indexOf(endField);
      count.value = branchStartIndex - branchEndIndex;
      route1.value = line3branch.sublist(branchStartIndex, branchEndIndex + 1);
      route2.value = [];
      direction.value = "Cairo University";
    } else if (line3branch.contains(startField) && (endField == "kit kat")) {
      branchStartIndex = line3branch.indexOf(startField);
      branchEndIndex = line3branch.indexOf("kit kat");
      count.value = branchStartIndex - branchEndIndex;
      route1.value = line3branch.sublist(branchEndIndex, branchStartIndex + 1);
      route2.value = [];
      direction.value = "Imbaba";
    }
  } else if ((startField == "cairo university" && line3branch.contains(endField)) ||
      line3branch.contains(startField) && (endField == "cairo university")) {
    line3branch.insert(0, "kit kat");
    line3branch.add("cairo university");

    if ((startField == "cairo university" && line3branch.contains(endField))) {
      branchStartIndex = line3branch.indexOf("cairo university");
      branchEndIndex = line3branch.indexOf(endField);
      count.value = branchStartIndex - branchEndIndex;
      route1.value = line3branch
          .sublist(branchEndIndex, branchStartIndex + 1)
          .reversed
          .toList();
      route2.value = [];
      direction.value = "Imbaba";
    } else if (line3branch.contains(startField) &&
        (endField == "cairo university")) {
      branchStartIndex = line3branch.indexOf(startField);
      branchEndIndex = line3branch.indexOf("cairo university");
      count.value = branchStartIndex - branchEndIndex;
      route1.value = line3branch.sublist(branchStartIndex, branchEndIndex + 1);
      route2.value = [];
      direction.value = "Cairo University";
    }
  } else if (line3.contains(startField) && line3branch.contains(endField) ||
      (line3branch.contains(startField) && (line3.contains(endField)))) {
    if ((line3.contains(startField) && line3branch.contains(endField)) &&
        (line3StartIndex < kitkatLine3)) {
      branchEndIndex = line3branch.indexOf(endField);

      count.value =
          ((line3StartIndex - kitkatLine3) - (branchEndIndex)).abs() + 1;

      route1.value = line3.sublist(line3StartIndex, kitkatLine3 + 1) +
          line3branch.sublist(0, branchEndIndex + 1);
      route2.value = [];
      direction.value = "Cairo University";
    } else if ((line3.contains(startField) && line3branch.contains(endField)) &&
        (line3StartIndex > kitkatLine3)) {
      branchEndIndex = line3branch.indexOf(endField);

      count.value =
          ((line3StartIndex - kitkatLine3) + (branchEndIndex)).abs() + 1;

      route1.value = line3.sublist(kitkatLine3, line3StartIndex + 1).reversed +
          line3branch.sublist(0, branchEndIndex + 1);
      route2.value = [];
      direction.value = "Cairo University";
    } else if ((line3branch.contains(startField) &&
            (line3.contains(endField))) &&
        (line3EndIndex < kitkatLine3)) {
      branchStartIndex = line3branch.indexOf(startField);

      count.value = (branchStartIndex - line3EndIndex + kitkatLine3).abs() + 1;

      route1.value = line3branch.sublist(0, branchStartIndex + 1).reversed +
          line3.sublist(line3EndIndex, kitkatLine3 + 1).reversed;
      route2.value = [];
      direction.value = "Adly Mansour";
    } else if ((line3branch.contains(startField) &&
            (line3.contains(endField))) &&
        (line3EndIndex > kitkatLine3)) {
      branchStartIndex = line3branch.indexOf(startField);

      count.value = (branchStartIndex + line3EndIndex - kitkatLine3).abs() + 1;

      route1.value = line3branch.sublist(0, branchStartIndex + 1).reversed +
          line3.sublist(kitkatLine3, line3EndIndex + 1);
      route2.value = [];
      direction.value = "Imbaba";
    }
  } else if (line1.contains(startField) && line1.contains(endField) ||
      (line1.contains(endField) && line1.contains(startField)) ||
      (line1.contains(startField) && line3branch.contains(endField)) ||
      (line3branch.contains(startField) && line1.contains(endField))) {
    if (line1.contains(startField) && line1.contains(endField) ||
        (line1.contains(endField) && line1.contains(startField))) {
      count.value = (line1EndIndex - line1StartIndex);
      if (count.isNegative) {
        direction.value = "El Marg";
        route1.value =
            line1.sublist(line1EndIndex, line1StartIndex + 1).reversed.toList();
        route2.value = [];
      } else {
        direction.value = "Helwan";
        route1.value = line1.sublist(line1StartIndex, line1EndIndex + 1);
        route2.value = [];
      }
    } else {
      if (line1.contains(startField) &&
          line3branch.contains(endField) &&
          line1StartIndex < nasserLine1) {
        branchEndIndex = line3branch.indexOf(endField);

        count.value = (line1StartIndex -
                    nasserLine1 +
                    nasserLine3 -
                    kitkatLine3 -
                    branchEndIndex)
                .abs() +
            1;

        route1.value = line1.sublist(line1StartIndex, nasserLine1 + 1);
        route2.value = line3.sublist(nasserLine3, kitkatLine3 + 1) +
            line3branch.sublist(0, branchEndIndex + 1);
        direction.value =
            "Line1 Direction : Helwan / Transfer Station : Nasser / Line3 Direction : Cairo University";
      } else if ((line1.contains(startField) &&
              line3branch.contains(endField)) &&
          (line1StartIndex > nasserLine1)) {
        branchEndIndex = line3branch.indexOf(endField);

        count.value = (line1StartIndex -
                    nasserLine1 -
                    nasserLine3 +
                    kitkatLine3 +
                    branchEndIndex)
                .abs() +
            1;

        route1.value =
            line1.sublist(nasserLine1, line1StartIndex + 1).reversed.toList();
        route2.value = line3.sublist(nasserLine3, kitkatLine3 + 1) +
            line3branch.sublist(0, branchEndIndex + 1);
        direction.value =
            "Line1 Direction : EL Marg / Transfer Station : Nasser / Line3 Direction : Cairo University";
      } else if ((line3branch.contains(startField) &&
              line1.contains(endField)) &&
          line1EndIndex < nasserLine1) {
        branchStartIndex = line3branch.indexOf(startField);
        count.value = (line1EndIndex -
                    nasserLine1 +
                    nasserLine3 -
                    kitkatLine3 -
                    branchStartIndex)
                .abs() +
            1;

        route1.value = line3branch.sublist(0, branchStartIndex + 1).reversed +
            line3.sublist(nasserLine3, kitkatLine3 + 1).reversed;
        route2.value =
            line1.sublist(line1EndIndex, nasserLine1 + 1).reversed.toList();
        direction.value =
            "Line3 Direction : Adly Mansour / Transfer Station : Nasser / Line1 Direction : EL Marg";
      } else if ((line3branch.contains(startField) &&
              line1.contains(endField)) &&
          line1EndIndex > nasserLine1) {
        branchStartIndex = line3branch.indexOf(startField);
        count.value = (line1EndIndex -
                    nasserLine1 -
                    nasserLine3 +
                    kitkatLine3 +
                    branchStartIndex)
                .abs() +
            1;

        route1.value = line3branch.sublist(0, branchStartIndex + 1).reversed +
            line3.sublist(nasserLine3, kitkatLine3 + 1).reversed;
        route2.value = line1.sublist(nasserLine1, line1EndIndex + 1);
        direction.value =
            "Line3 Direction : Adly Mansour / Transfer Station : Nasser / Line1 Direction : Helwan";
      }
    }
  } else if (line2.contains(startField) && line2.contains(endField) ||
      line2.contains(endField) && line2.contains(startField) ||
      (line2.contains(startField) && line3branch.contains(endField)) ||
      (line3branch.contains(startField) && line2.contains(endField))) {
    if (line2.contains(startField) && line2.contains(endField) ||
        line2.contains(endField) && line2.contains(startField)) {
      count.value = line2EndIndex - line2StartIndex;
      if (count.isNegative) {
        direction.value = "Shubra";
        route1.value =
            line2.sublist(line2EndIndex, line2StartIndex + 1).reversed.toList();
        route2.value = [];
      } else {
        direction.value = "El Monib";
        route1.value = line2.sublist(line2StartIndex, line2EndIndex + 1);
        route2.value = [];
      }
    } else {
      line3branch.add("cairo university");
      final cairouniline3 = line3branch.indexOf("cairo university");

      if (line2.contains(startField) &&
          line3branch.contains(endField) &&
          line2StartIndex > line2.indexOf("cairo university") &&
          line2StartIndex > attabaLine2) {
        branchEndIndex = line3branch.indexOf(endField);

        count.value = (line2StartIndex - cairoUniversityLine2) +
            (cairouniline3 - branchEndIndex);

        route1.value = line2
            .sublist(cairoUniversityLine2, line2StartIndex + 1)
            .reversed
            .toList();
        route2.value = line3branch
            .sublist(branchEndIndex, cairouniline3 + 1)
            .reversed
            .toList();
        direction.value =
            "Line2 Direction : Shubra / Transfer Station : Cairo University / Line3 Direction : Adly Mansour";
      } else if (line2.contains(startField) &&
          line3branch.contains(endField) &&
          line2StartIndex < line2.indexOf("cairo university") &&
          line2StartIndex > attabaLine2) {
        branchEndIndex = line3branch.indexOf(endField);

        count.value = (line2StartIndex - cairoUniversityLine2) -
            (cairouniline3 - branchEndIndex);

        route1.value = line2.sublist(line2StartIndex, cairoUniversityLine2 + 1);
        route2.value = line3branch
            .sublist(branchEndIndex, cairouniline3 + 1)
            .reversed
            .toList();
        direction.value =
            "Line2 Direction : El Monib / Transfer Station : Cairo University / Line3 Direction : Adly Mansour";
      } else if ((line3branch.contains(startField) &&
              line2.contains(endField)) &&
          line2EndIndex > line2.indexOf("cairo university") &&
          line2EndIndex > attabaLine2) {
        branchStartIndex = line3branch.indexOf(startField);

        count.value = (line2EndIndex - cairoUniversityLine2) +
            (cairouniline3 - branchStartIndex);

        route1.value = line3branch.sublist(branchStartIndex, cairouniline3 + 1);
        route2.value = line2.sublist(cairoUniversityLine2, line2EndIndex + 1);
        direction.value =
            "Line3 Direction : Cairo University / Transfer Station : Cairo University / Line2 Direction : El Monib";
      } else if ((line3branch.contains(startField) &&
              line2.contains(endField)) &&
          line2EndIndex < line2.indexOf("cairo university") &&
          line2EndIndex > attabaLine2) {
        branchStartIndex = line3branch.indexOf(startField);
        count.value = (line2EndIndex - cairoUniversityLine2) -
            (cairouniline3 - branchStartIndex);

        route1.value = line3branch.sublist(branchStartIndex, cairouniline3 + 1);
        route2.value = line2
            .sublist(line2EndIndex, cairoUniversityLine2 + 1)
            .reversed
            .toList();
        direction.value =
            "Line3 Direction : Cairo University / Transfer Station : Cairo University / Line2 Direction : Shubra";
      } else if (line2.contains(startField) && line3branch.contains(endField)) {
        branchEndIndex = line3branch.indexOf(endField);

        count.value = (line2StartIndex -
                    attabaLine2 +
                    attabaLine3 -
                    kitkatLine3 -
                    branchEndIndex)
                .abs() +
            1;

        route1.value = line2.sublist(line2StartIndex, attabaLine2 + 1);
        route2.value = line3.sublist(attabaLine3, kitkatLine3 + 1) +
            line3branch.sublist(0, branchEndIndex + 1);
        direction.value =
            "Line2 Direction : El Monib / Transfer Station : Attaba / Line3 Direction : Cairo University";
      } else if ((line3branch.contains(startField) &&
          line2.contains(endField))) {
        branchStartIndex = line3branch.indexOf(startField);

        count.value = (line2EndIndex -
                    attabaLine2 +
                    attabaLine3 -
                    kitkatLine3 -
                    branchStartIndex)
                .abs() +
            1;

        route1.value = line3branch.sublist(1, branchStartIndex + 1).reversed +
            line3.sublist(attabaLine3, kitkatLine3).reversed;
        route2.value =
            line2.sublist(line2EndIndex, attabaLine2 + 1).reversed.toList();
        direction.value =
            "Line3 Direction : Adly Mansour / Transfer Station : Attaba / Line2 Direction : Shubra";
      }
    }
  } else if (line3.contains(startField) && line3.contains(endField)) {
    count.value = line3EndIndex - line3StartIndex;

    if (count.isNegative) {
      direction.value = "Adly Mansour";
      route1.value =
          line3.sublist(line3EndIndex, line3StartIndex + 1).reversed.toList();
      route2.value = [];
    } else {
      direction.value = "Imbaba";
      route1.value = line3.sublist(line3StartIndex, line3EndIndex + 1);
      route2.value = [];
    }
  } else if ((line1.contains(startField) && line2.contains(endField)) &&
      line1StartIndex < alshohadaaLine1 &&
      line2EndIndex > sadatLine2) {
    count.value =
        (alshohadaaLine1 - line1StartIndex) - (alshohadaaLine2 - line2EndIndex);
    direction.value =
        "Line1 Direction : Helwan / Transfer Station : AlShohadaa / Line2 Direction : El Monib";
    route1.value = line1.sublist(line1StartIndex, alshohadaaLine1 + 1);
    route2.value = line2.sublist(alshohadaaLine2, line2EndIndex + 1);
  } else if ((line2.contains(startField) && line1.contains(endField)) &&
      line1EndIndex < alshohadaaLine1 &&
      line2StartIndex > sadatLine2) {
    count.value =
        (alshohadaaLine2 - line2StartIndex) - (alshohadaaLine1 - line1EndIndex);
    direction.value =
        "Line2 Direction : Shubra / Transfer Station : AlShohadaa / Line1 Direction : El Marg";
    route1.value =
        line2.sublist(alshohadaaLine2, line2StartIndex + 1).reversed.toList();
    route2.value =
        line1.sublist(line1EndIndex, alshohadaaLine1 + 1).reversed.toList();
  } else if ((line1.contains(startField)) &&
      line2.contains(endField) &&
      line1StartIndex > sadatLine1 &&
      line2EndIndex > sadatLine2) {
    count.value = (sadatLine1 - line1StartIndex) + (sadatLine2 - line2EndIndex);
    route1.value =
        line1.sublist(sadatLine1, line1StartIndex + 1).reversed.toList();
    route2.value = line2.sublist(sadatLine2, line2EndIndex + 1);
    direction.value =
        "Line1 Direction : El Marg / Transfer Station : Sadat / Line2 Direction : El Monib";
  } else if ((line2.contains(startField)) &&
      (line1.contains(endField)) &&
      line2StartIndex > sadatLine2 &&
      line1EndIndex > sadatLine1) {
    count.value = (line2StartIndex - sadatLine2) + (line1EndIndex - sadatLine1);
    direction.value =
        "Line2 Direction : Shubra / Transfer Station : Sadat / Line1 Direction : Helwan";
    route1.value =
        line2.sublist(sadatLine2, line2StartIndex + 1).reversed.toList();
    route2.value = line1.sublist(sadatLine1, line1EndIndex + 1);
  } else if ((line1.contains(startField) && line2.contains(endField)) &&
      line1StartIndex < alshohadaaLine1 &&
      line2EndIndex < alshohadaaLine2) {
    count.value =
        (line1StartIndex - alshohadaaLine1) + (line2EndIndex - alshohadaaLine2);
    direction.value =
        "Line1 Direction : Helwan / Transfer Station : AlShohadaa / Line2 Direction : Shubra";
    route1.value = line1.sublist(line1StartIndex, alshohadaaLine1 + 1);
    route2.value =
        line2.sublist(line2EndIndex, alshohadaaLine2 + 1).reversed.toList();
  } else if ((line2.contains(startField)) &&
      (line1.contains(endField)) &&
      line2StartIndex < alshohadaaLine2 &&
      line1EndIndex < alshohadaaLine1) {
    count.value =
        (line2StartIndex - alshohadaaLine2) + (line1EndIndex - alshohadaaLine1);
    direction.value =
        "Line2 Direction : El Monib / Transfer Station : AlShohadaa / Line1 Direction : El Marg";
    route1.value = line2.sublist(line2StartIndex, alshohadaaLine2 + 1);
    route2.value =
        line1.sublist(line1EndIndex, alshohadaaLine1 + 1).reversed.toList();
  } else if ((line1.contains(startField) && line2.contains(endField)) &&
      line1StartIndex > sadatLine1 &&
      line2EndIndex < alshohadaaLine2) {
    count.value = (line1StartIndex - sadatLine1) - (line2EndIndex - sadatLine2);
    direction.value =
        "Line1 Direction : El Marg / Transfer Station : Sadat / Line2 Direction : Shubra";
    route1.value =
        line1.sublist(sadatLine1, line1StartIndex + 1).reversed.toList();
    route2.value =
        line2.sublist(line2EndIndex, sadatLine2 + 1).reversed.toList();
  } else if ((line2.contains(startField)) &&
      (line1.contains(endField)) &&
      line2StartIndex < alshohadaaLine2 &&
      line1EndIndex > sadatLine1) {
    count.value = (line2StartIndex - sadatLine2) - (line1EndIndex - sadatLine1);
    direction.value =
        "Line2 Direction : El Monib / Transfer Station : AlShohadaa / Line1 Direction : Helwan";
    route1.value = line2.sublist(line2StartIndex, alshohadaaLine2 + 1);
    route2.value = line1.sublist(alshohadaaLine1, line1EndIndex + 1);
  } else if (line1.contains(startField) && line2.contains(endField) && (line1StartIndex == line1.indexOf("orabi")) ||
      (line1StartIndex == line1.indexOf("nasser"))) {
    count.value =
        (line1StartIndex - alshohadaaLine1) - (line2EndIndex - alshohadaaLine2);
    if (count.isNegative) {
      direction.value =
          "Line1 Direction : Helwan / Transfer Station : Sadat / Line2 Direction : El Monib";
      route1.value = line1.sublist(line1StartIndex, sadatLine1 + 1);
      route2.value = line2.sublist(sadatLine2, line2EndIndex + 1);
    } else {
      direction.value =
          "Line1 Direction : El Marg / Transfer Station : AlShohadaa / Line2 Direction : Shubra";
      route1.value =
          line1.sublist(alshohadaaLine1, line1StartIndex + 1).reversed.toList();
      route2.value =
          line2.sublist(line2EndIndex, alshohadaaLine2 + 1).reversed.toList();
    }
  } else if ((line2.contains(startField)) && (line1.contains(endField)) && (line1EndIndex == line1.indexOf("orabi")) ||
      (line1EndIndex == line1.indexOf("nasser"))) {
    count.value = (line1EndIndex - sadatLine1) - (line2StartIndex - sadatLine2);
    if (count.isNegative) {
      direction.value =
          "Line2 Direction : Shubra / Transfer Station : Sadat / Line1 Direction : El Marg";
      route2.value =
          line1.sublist(line1EndIndex, sadatLine1 + 1).reversed.toList();
      route1.value =
          line2.sublist(sadatLine2, line2StartIndex + 1).reversed.toList();
    } else {
      direction.value =
          "Line2 Direction : El Monib / Transfer Station : AlShohadaa / Line1 Direction : Helwan";
      route2.value = line1.sublist(alshohadaaLine1, line1EndIndex + 1);
      route1.value = line2.sublist(line2StartIndex, alshohadaaLine2 + 1);
    }
  } else if (line1.contains(startField) && line2.contains(endField) && (line2EndIndex == line2.indexOf("attaba")) ||
      (line2EndIndex == line2.indexOf("mohamed naguib"))) {
    count.value =
        (line1StartIndex - alshohadaaLine1) - (line2EndIndex - alshohadaaLine2);
    if (count.isNegative) {
      direction.value =
          "Line1 Direction : Helwan / Transfer Station : AlShohadaa / Line2 Direction : El Monib";
      route1.value = line1.sublist(line1StartIndex, alshohadaaLine1 + 1);
      route2.value = line2.sublist(alshohadaaLine2, line2EndIndex + 1);
    } else {
      direction.value =
          "Line1 Direction : El Marg / Transfer Station : Sadat / Line2 Direction : Shubra";
      route1.value =
          line1.sublist(sadatLine1, line1StartIndex + 1).reversed.toList();
      route2.value =
          line2.sublist(line2EndIndex, sadatLine2 + 1).reversed.toList();
    }
  } else if (line2.contains(startField) && line1.contains(endField) && (line2StartIndex == line2.indexOf("attaba")) ||
      (line2StartIndex == line2.indexOf("mohamed naguib"))) {
    count.value = (line2StartIndex - sadatLine2) - (line1EndIndex - sadatLine1);
    if (count.isNegative) {
      direction.value =
          "Line2 Direction : El Monib / Transfer Station : Sadat / Line1 Direction : Helwan";
      route2.value = line1.sublist(sadatLine1, line1EndIndex + 1);
      route1.value = line2.sublist(line2StartIndex, sadatLine2 + 1);
    } else {
      direction.value =
          "Line2 Direction : Shubra / Transfer Station : AlShohadaa / Line1 Direction : El Marg";
      route2.value =
          line1.sublist(line1EndIndex, alshohadaaLine1 + 1).reversed.toList();
      route1.value =
          line2.sublist(alshohadaaLine2, line2StartIndex + 1).reversed.toList();
    }
  } else if (((line1.contains(startField) && line3.contains(endField)) && (line1StartIndex > nasserLine1 && line3EndIndex > nasserLine3)) ||
      ((line1.contains(startField) && line3.contains(endField)) &&
          (line1StartIndex < nasserLine1 && line3EndIndex < nasserLine3))) {
    if (line1StartIndex > nasserLine1 && line3EndIndex > nasserLine3) {
      route1.value =
          line1.sublist(nasserLine1, line1StartIndex + 1).reversed.toList();
      route2.value = line3.sublist(nasserLine3, line3EndIndex + 1);
      direction.value =
          "Line1 Direction : El Marg / Transfer Station : Nasser / Line3 Direction : Imbaba";
    } else {
      route1.value = line1.sublist(line1StartIndex, nasserLine1 + 1);
      route2.value =
          line3.sublist(line3EndIndex, nasserLine3 + 1).reversed.toList();
      direction.value =
          "Line1 Direction : Helwan / Transfer Station : Nasser / Line3 Direction : Adly Mansour";
    }
    count.value =
        (line1StartIndex - nasserLine1) + (line3EndIndex - nasserLine3);
  } else if ((line1.contains(startField) && line3.contains(endField) && (line1StartIndex < nasserLine1 && line3EndIndex > nasserLine3)) ||
      ((line1.contains(startField) && line3.contains(endField)) &&
          (line1StartIndex > nasserLine1 && line3EndIndex < nasserLine3))) {
    if (line1StartIndex < nasserLine1 && line3EndIndex > nasserLine3) {
      route1.value = line1.sublist(line1StartIndex, nasserLine1 + 1);
      route2.value = line3.sublist(nasserLine3, line3EndIndex + 1);
      direction.value =
          "Line1 Direction : Helwan / Transfer Station : Nasser / Line3 Direction : Imbaba";
    } else {
      route1.value =
          line1.sublist(nasserLine1, line1StartIndex + 1).reversed.toList();
      route2.value =
          line3.sublist(line3EndIndex, nasserLine3 + 1).reversed.toList();
      direction.value =
          "Line1 Direction : El Marg / Transfer Station : Nasser / Line3 Direction : Adly Mansour";
    }
    count.value =
        (line1StartIndex - nasserLine1) - (line3EndIndex - nasserLine3);
  } else if ((line3.contains(startField) && line1.contains(endField) && (line3StartIndex > nasserLine3 && line1EndIndex > nasserLine1)) ||
      (line3.contains(startField) && line1.contains(endField)) &&
          (line3StartIndex < nasserLine3 && line1EndIndex < nasserLine1)) {
    if (line3StartIndex > nasserLine3 && line1EndIndex > nasserLine1) {
      route1.value =
          line3.sublist(nasserLine3, line3StartIndex + 1).reversed.toList();
      route2.value = line1.sublist(nasserLine1, line1EndIndex + 1);
      direction.value =
          "Line3 Direction : Adly Mansour / Transfer Station : Nasser / Line1 Direction : Helwan";
    } else {
      route1.value = line3.sublist(line3StartIndex, nasserLine3 + 1);
      route2.value =
          line1.sublist(line1EndIndex, nasserLine1 + 1).reversed.toList();
      direction.value =
          "Line3 Direction : Imbaba / Transfer Station : Nasser / Line1 : Direction El Marg";
    }

    count.value =
        (line3StartIndex - nasserLine3) + (line1EndIndex - nasserLine1);
  } else if ((line3.contains(startField) && line1.contains(endField) && (line3StartIndex < nasserLine3 && line1EndIndex > nasserLine1)) ||
      (line3.contains(startField) && line1.contains(endField)) && (line3StartIndex > nasserLine3 && line1EndIndex < nasserLine1)) {
    if (line3StartIndex < nasserLine3 && line1EndIndex > nasserLine1) {
      route1.value = line3.sublist(line3StartIndex, nasserLine3 + 1);
      route2.value = line1.sublist(nasserLine1, line1EndIndex + 1);
      direction.value =
          "Line3 Direction : Imbaba / Transfer Station : Nasser / Line1 Direction : Helwan";
    } else {
      route1.value =
          line3.sublist(nasserLine3, line3StartIndex + 1).reversed.toList();
      route2.value =
          line1.sublist(line1EndIndex, nasserLine1 + 1).reversed.toList();
      direction.value =
          "Line3 Direction : Adly Mansour / Transfer Station : Nasser / Line1 Direction : El Marg";
    }
    count.value =
        (line3StartIndex - nasserLine3) - (line1EndIndex - nasserLine1);
  } else if (((line2.contains(startField) && line3.contains(endField)) && (line2StartIndex > attabaLine2 && line3EndIndex > attabaLine3)) || (line2.contains(startField) && line3.contains(endField) && (line2StartIndex < attabaLine2 && line3EndIndex < attabaLine3))) {
    if (line2StartIndex > attabaLine2 && line3EndIndex > attabaLine3) {
      route1.value =
          line2.sublist(attabaLine2, line2StartIndex + 1).reversed.toList();
      route2.value = line3.sublist(attabaLine3, line3EndIndex + 1);
      direction.value =
          "Line2 Direction : Shubra / Transfer Station : Attaba / Line3 Direction : Imbaba";
    } else {
      route1.value = line2.sublist(line2StartIndex, attabaLine2 + 1);
      route2.value =
          line3.sublist(line3EndIndex, attabaLine3 + 1).reversed.toList();
      direction.value =
          "Line2 Direction : El Monib / Transfer Station : Attaba / Line3 Direction : Adly Mansour";
    }
    count.value =
        (line2StartIndex - attabaLine2) + (line3EndIndex - attabaLine3);
  } else if (((line2.contains(startField) && line3.contains(endField)) && (line2StartIndex < attabaLine2 && line3EndIndex > attabaLine3)) || (line2.contains(startField) && line3.contains(endField) && (line2StartIndex > attabaLine2 && line3EndIndex < attabaLine3))) {
    if (line2StartIndex < attabaLine2 && line3EndIndex > attabaLine3) {
      route1.value = line2.sublist(line2StartIndex, attabaLine2 + 1);
      route2.value = line3.sublist(attabaLine3, line3EndIndex + 1);
      direction.value =
          "Line2 Direction : El Monib / Transfer Station : Attaba / Line3 Direction : Imbaba";
    } else {
      route1.value =
          line2.sublist(attabaLine2, line2StartIndex + 1).reversed.toList();
      route2.value =
          line3.sublist(line3EndIndex, attabaLine3 + 1).reversed.toList();
      direction.value =
          "Line2 Direction : Shubra / Transfer Station : Attaba / Line3 Direction : Adly Mansour";
    }

    count.value =
        (line2StartIndex - attabaLine2) - (line3EndIndex - attabaLine3);
  } else if ((line3.contains(startField) && line2.contains(endField) && (line3StartIndex > attabaLine3 && line2EndIndex > attabaLine2)) || (line3.contains(startField) && line2.contains(endField)) && (line3StartIndex < attabaLine3 && line2EndIndex < attabaLine2)) {
    if (line3StartIndex > attabaLine3 && line2EndIndex > attabaLine2) {
      route1.value =
          line3.sublist(attabaLine3, line3StartIndex + 1).reversed.toList();
      route2.value = line2.sublist(attabaLine2, line2EndIndex + 1);
      direction.value =
          "Line3 Direction : Adly Mansour / Transfer Station : Attaba / Line2 Direction : El Monib";
    } else {
      route1.value = line3.sublist(line3StartIndex, attabaLine3 + 1);
      route2.value =
          line2.sublist(line2EndIndex, attabaLine2 + 1).reversed.toList();
      direction.value =
          "Line3 Direction : Imbaba / Transfer Station : Attaba / Line2 Direction : Shubra";
    }

    count.value =
        (line3StartIndex - attabaLine3) + (line2EndIndex - attabaLine2);
  } else if ((line3.contains(startField) && line2.contains(endField) && (line3StartIndex < attabaLine3 && line2EndIndex > attabaLine2)) || (line3.contains(startField) && line2.contains(endField)) && (line3StartIndex > attabaLine3 && line2EndIndex < attabaLine2)) {
    if (line3StartIndex < attabaLine3 && line2EndIndex > attabaLine2) {
      route1.value = line3.sublist(line3StartIndex, attabaLine3 + 1);
      route2.value = line2.sublist(attabaLine2, line2EndIndex + 1);
      direction.value =
          "Line3 Direction : Imbaba / Transfer Station : Attaba / Line2 Direction : El Monib";
    } else {
      route1.value =
          line3.sublist(attabaLine3, line3StartIndex + 1).reversed.toList();
      route2.value =
          line2.sublist(line2EndIndex, attabaLine2 + 1).reversed.toList();
      direction.value =
          "Line3 Direction : Adly Mansour / Transfer Station : Attaba / Line2 Direction : Shubra";
    }

    count.value =
        (line3StartIndex - attabaLine3) - (line2EndIndex - attabaLine2);
  } else {
    count.value = 0;
    direction.value = "";
    route1.value = [];
    route2.value = [];
    Get.snackbar("Error", "Wrong Station Please Enter The Correct Station",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red);
  }

  if (count.abs() <= 9 && count.value != 0) {
    price.value = 8;
  } else if (count.abs() <= 16 && count.value != 0) {
    price.value = 10;
  } else if (count.abs() <= 23 && count.value != 0) {
    price.value = 15;
  } else if (count.abs() <= 39 && count.value != 0) {
    price.value = 20;
  } else {
    price.value = 0;
  }

  final allLines = <Station>[];
  allLines.addAll(line1class);
  allLines.addAll(line2class);
  allLines.addAll(line3class);
  allLines.addAll(line3branchclass);

  for (Station value1 in allLines) {
    if (value1.stationName.toLowerCase() == startField) {
      final theStart = Station(
          stationName: value1.stationName,
          latitude: value1.latitude,
          longitude: value1.longitude,
          distance: 0);

      for (Station value in allLines) {
        if (value.stationName.toLowerCase() == endField) {
          final theEnd = Station(
              stationName: value.stationName,
              latitude: value.latitude,
              longitude: value.longitude,
              distance: 0);

          final spaceBetweenStations = Geolocator.distanceBetween(
              theStart.latitude,
              theStart.longitude,
              theEnd.latitude,
              theEnd.longitude);

          spaceBetween.value = "${spaceBetweenStations.toInt()} Meters";
          return;
        }
      }
    }
  }
}
