import 'package:http/http.dart' as http;


class Calorie_Manager{
  static final String apiKey = "4ebd7c76f74531cb7c46ee5a0b6d318d"; 
  static final String appid = "fb8369bf";
  // remove the credentials from above before adding to the repository
  final String apiBaseUrl = "https://api.edamam.com/api/nutrition-data";
  Calorie_Manager();

  Future<String> queryFood(String food) async{

  }


  
}
void main(List<String> args) {
  Calorie_Manager tcm = new Calorie_Manager();
}