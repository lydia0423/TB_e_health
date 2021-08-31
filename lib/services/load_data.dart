import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tb_e_health/models/faq_data.dart';

class LoadDataService {
// Fetch content from the json file
  Future<List<dynamic>> readJson() async {
    final String response = await rootBundle.loadString('assets/json/faq_data.json');
    List<dynamic> data = json
        .decode(response)['faq_items']
        .map((data) => FaqData.fromJson(data))
        .toList();
    return data;
  }
}
