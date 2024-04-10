import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:foodes/model/meal_model.dart';

class APIService {
  Future<Meal> getMeal(int index) async {
    var url = Uri.parse('https://api.freeapi.app/api/v1/public/meals/$index');
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var meal = Meal.fromJson(json);

    if (meal.statusCode == 200) {
      log(meal.data!.strMeal.toString());
      return meal;
    }

    throw Exception(meal.message);
  }
}
