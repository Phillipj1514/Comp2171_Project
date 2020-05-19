import 'package:Vainfitness/core/nutrition/Nutrition_Data.dart';
import 'package:Vainfitness/core/util/Nutrition_Manager.dart';

enum Measure{number, weight}
class Food{
  String name;
  double quantity = 0;
  Measure measure;
  Nutrition_Data nutrition_data = new Nutrition_Data();
  Nutrition_Manager nutrition_manager = new Nutrition_Manager();

  Food({this.name = "EDIBLE", this.quantity =0, String measure="NUMBER"}){
    if(measure == "NUMBER"){this.measure = Measure.number;}
    else{this.measure = Measure.weight;}
  }

  // Getters
  String getName() => this.name;
  double getQuantity() => this.quantity;
  String getMeasure(){
    if(measure == Measure.number){return "NUMBER";}
    return "WEIGHT";
  }
  int getCalorie() => this.nutrition_data.getCalorie();
  double getFat() => this.nutrition_data.getFat();
  double getCarbohydrates() => this.nutrition_data.getCarbohydrates();
  double getSugar() => this.nutrition_data.getSugar();
  double getProtein() => this.nutrition_data.getProtein();

  // Setters
  void setName(String name) => this.name = name;
  void setQuantity(double quantity) => this.quantity = quantity;
  void  setMeasure(String measure){
    this.measure = measure == "NUMBER" ? Measure.number : Measure.weight;
  }

  // Modifiers
  Future<void> updateCalorie() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await nutrition_manager.queryFood(food);
    this.nutrition_data.setCalorie(nutrition_manager.extractCalorie(foodData));
  }

  Future<void> updateFat() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await nutrition_manager.queryFood(food);
    this.nutrition_data.setFat(nutrition_manager.extractFat(foodData));
  }

  Future<void> updateCarbohydrates() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await nutrition_manager.queryFood(food);
    this.nutrition_data.setCarbohydrates(nutrition_manager.extractCarbohydrate(foodData));
  }

  Future<void> updateSugar() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await nutrition_manager.queryFood(food);
    this.nutrition_data.setSugar(nutrition_manager.extractSugar(foodData));
  }

  Future<void> updateProtein() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await nutrition_manager.queryFood(food);
    this.nutrition_data.setProtein(nutrition_manager.extractProtien(foodData));
  }

  Future<void> updateNutritionalDetail() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await nutrition_manager.queryFood(food);
    this.nutrition_data.setCalorie(nutrition_manager.extractCalorie(foodData));
    this.nutrition_data.setFat(nutrition_manager.extractFat(foodData));
    this.nutrition_data.setCarbohydrates(nutrition_manager.extractCarbohydrate(foodData));
    this.nutrition_data.setSugar(nutrition_manager.extractSugar(foodData));
    this.nutrition_data.setProtein(nutrition_manager.extractProtien(foodData));
  }

  Map<String, dynamic> mapify(){
    return{
      "name": this.name,
      "quantity": this.quantity,
      "measure": this.getMeasure(),
      "nutrition_detail": this.nutrition_data.mapify()
    };
  }
  Food.fromMap(Map mapdata){
    this.name = mapdata["name"];
    this.quantity = mapdata["quantity"];
    this.setMeasure(mapdata["measure"]);
    this.nutrition_data = new Nutrition_Data.fromMap(mapdata["nutrition_details"]);
  }
}

void main(List<String> args) async{
  Food tf = new Food(name: "apple",quantity: 1);
  print(tf.getMeasure());
  tf.setMeasure("WEIGHT");
  print(tf.getMeasure());
  print("cal "+tf.getCalorie().toString());
  await tf.updateNutritionalDetail();
  print("cal "+tf.getCalorie().toString());
  print("fat "+tf.getFat().toString());
  print("car "+tf.getCarbohydrates().toString());
  print("sug "+tf.getSugar().toString());
  print("pro "+tf.getProtein().toString());

}