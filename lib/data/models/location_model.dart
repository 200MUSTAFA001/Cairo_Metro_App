// To parse this JSON data, do
//
//     final addressResultModel = addressResultModelFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) =>
    List<LocationModel>.from(
        json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  final String placeId;
  final String osmId;
  final String osmType;
  final String licence;
  final String lat;
  final String lon;
  final List<String> boundingbox;
  final String categoryClass;
  final String type;
  final String displayName;
  final String displayPlace;
  final String displayAddress;
  final Address address;

  LocationModel({
    required this.placeId,
    required this.osmId,
    required this.osmType,
    required this.licence,
    required this.lat,
    required this.lon,
    required this.boundingbox,
    required this.categoryClass,
    required this.type,
    required this.displayName,
    required this.displayPlace,
    required this.displayAddress,
    required this.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        placeId: json["place_id"],
        osmId: json["osm_id"],
        osmType: json["osm_type"],
        licence: json["licence"],
        lat: json["lat"],
        lon: json["lon"],
        boundingbox: List<String>.from(json["boundingbox"].map((x) => x)),
        categoryClass: json["class"],
        type: json["type"],
        displayName: json["display_name"],
        displayPlace: json["display_place"],
        displayAddress: json["display_address"],
        address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "osm_id": osmId,
        "osm_type": osmType,
        "licence": licence,
        "lat": lat,
        "lon": lon,
        "boundingbox": List<dynamic>.from(boundingbox.map((x) => x)),
        "class": categoryClass,
        "type": type,
        "display_name": displayName,
        "display_place": displayPlace,
        "display_address": displayAddress,
        "address": address.toJson(),
      };
}

class Address {
  final String name;
  final String? road;
  final String? neighbourhood;
  final String? suburb;
  final String? city;
  final String? state;
  final String? stateCode;
  final String? postcode;
  final String country;
  final String countryCode;
  final String? houseNumber;
  final String? county;

  Address({
    required this.name,
    this.road,
    this.neighbourhood,
    this.suburb,
    this.stateCode,
    this.county,
    this.city,
    this.state,
    this.postcode,
    required this.country,
    required this.countryCode,
    this.houseNumber,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        road: json["road"],
        neighbourhood: json["neighbourhood"],
        suburb: json["suburb"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        countryCode: json["country_code"],
        houseNumber: json["house_number"],
        stateCode: json["state_code"],
        county: json["county"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "road": road,
        "neighbourhood": neighbourhood,
        "suburb": suburb,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "country_code": countryCode,
        "house_number": houseNumber,
        "state_code": stateCode,
        "county": county,
      };
}
