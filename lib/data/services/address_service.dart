import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../api_key.dart';
import '../models/location_model.dart';

class LocationService {
  final dio = Dio();
  Future<List<LocationModel>> getSimilarLocation(String location) async {
    try {
      const baseUrl = "https://api.locationiq.com/v1";
      final url =
          "$baseUrl/autocomplete?key=$apiKey&q=$location&countrycodes=eg&accept-language=ar";
      final response = await dio.get(url);
      final jsonString = json.encode(response.data);
      final result = locationModelFromJson(jsonString);

      return result;
    } catch (e) {
      Get.log(e.toString());
      return [];
    }
  }
}
