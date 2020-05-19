import 'dart:convert';

import 'package:http/http.dart' as http;


class Nutrition_Manager{
  static final String apiKey = "4ebd7c76f74531cb7c46ee5a0b6d318d"; 
  static final String appId = "fb8369bf";
  // remove the credentials from above before adding to the repository
  static String apiBaseUrl = "https://api.edamam.com/api/nutrition-data?app_id="+appId+"&app_key="+apiKey+"&ingr=";
  Nutrition_Manager();

  Future<Map<String, dynamic>> queryFood(String food) async{
    // encode the url for the api and attach the food items to the reques
    String request = Uri.encodeFull(apiBaseUrl+food);
    // print(request);
    // send a get request to theserver and process the reponse
    final response = await http.get(request);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      // return response.body;
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to talk to API');
    }
  }

  int extractCalorie(var foodData) {
    return foodData['calories'];
  }

  double extractFat(var foodData) {
    if(foodData['totalNutrients']['FAT'] != null){
      return foodData['totalNutrients']['FAT']['quantity'];
    }
    return -1;
  }

  double extractCarbohydrate(var foodData) {
    if(foodData['totalNutrients']['CHOCDF'] != null){
      return foodData['totalNutrients']['CHOCDF']['quantity'];
    }
  }

  double extractSugar(var foodData) {
    if(foodData['totalNutrients']['SUGAR'] != null){
      return foodData['totalNutrients']['SUGAR']['quantity'];
    }
    
    return -1;
  }

  double extractProtien(var foodData) {
    if(foodData['totalNutrients']['PROCNT'] != null){
      return foodData['totalNutrients']['PROCNT']['quantity'];
    }
    return -1;
  }

  Future<void> testApiExtraction() async{
    var foodData = await this.queryFood("1 cup juice");
    // print(foodData);
    print(extractCalorie(foodData));
    if(extractCalorie(foodData) > 0){
      print(extractFat(foodData));
      print(extractCarbohydrate(foodData));
      print(extractSugar(foodData));
      print(extractProtien(foodData));
    }
    
  }
  
}
void main(List<String> args) async{
  Nutrition_Manager tnm = new Nutrition_Manager();
  await tnm.testApiExtraction();
}