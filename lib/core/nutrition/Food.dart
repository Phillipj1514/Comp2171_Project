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
  
  Nutrition_Data getNutrients() => this.nutrition_data;

  // Setters
  void setName(String name) => this.name = name;
  
  void setQuantity(double quantity) => this.quantity = quantity;
  
  void  setMeasure(String measure){
    this.measure = measure == "NUMBER" ? Measure.number : Measure.weight;
  }

  // Modifiers
  Future<void> updateCalorie() async{
    try{
      String food = this.quantity.toString()+" "+this.name;
      var foodData = await nutrition_manager.queryFood(food);
      this.nutrition_data.setCalorie(nutrition_manager.extractCalorie(foodData));
    }catch(e){
      print(e.toString());
    }
    
  }

  Future<void> updateFat() async{
    try{
      String food = this.quantity.toString()+" "+this.name;
      var foodData = await nutrition_manager.queryFood(food);
      this.nutrition_data.setFat(nutrition_manager.extractFat(foodData));
    }catch(e){
      print(e.toString());
    }
   
  }

  Future<void> updateCarbohydrates() async{
    try{
      String food = this.quantity.toString()+" "+this.name;
      var foodData = await nutrition_manager.queryFood(food);
      this.nutrition_data.setCarbohydrates(nutrition_manager.extractCarbohydrate(foodData));
    }catch(e){
      print(e.toString());
    }
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await nutrition_manager.queryFood(food);
    this.nutrition_data.setCarbohydrates(nutrition_manager.extractCarbohydrate(foodData));
  }

  Future<void> updateSugar() async{
    try{
      String food = this.quantity.toString()+" "+this.name;
      var foodData = await nutrition_manager.queryFood(food);
      this.nutrition_data.setSugar(nutrition_manager.extractSugar(foodData));
    }catch(e){
      print(e.toString());
    }
    
  }

  Future<void> updateProtein() async{
    try{
      String food = this.quantity.toString()+" "+this.name;
      var foodData = await nutrition_manager.queryFood(food);
      this.nutrition_data.setProtein(nutrition_manager.extractProtien(foodData));
    }catch(e){
      print(e.toString());
    }
    
  }

  Future<void> updateNutritionalDetail() async{
    try{
      String food = this.quantity.toString()+" "+this.name;
      var foodData = await nutrition_manager.queryFood(food);
      this.nutrition_data.setCalorie(nutrition_manager.extractCalorie(foodData));
      this.nutrition_data.setFat(nutrition_manager.extractFat(foodData));
      this.nutrition_data.setCarbohydrates(nutrition_manager.extractCarbohydrate(foodData));
      this.nutrition_data.setSugar(nutrition_manager.extractSugar(foodData));
      this.nutrition_data.setProtein(nutrition_manager.extractProtien(foodData));
    }catch(e){
      print(e.toString());
    }
    
  }

  // Database manager methods
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
    this.nutrition_data = new Nutrition_Data.fromMap(mapdata["nutrition_detail"]);
  }
}

void main(List<String> args) async{
  Food tf = new Food(name: "apple",quantity: 1);
  print(tf.getMeasure());
  tf.setMeasure("WEIGHT");
  print(tf.getMeasure());
  print("cal "+tf.getNutrients().getCalorie().toString());
  await tf.updateNutritionalDetail();
  print("cal "+tf.getNutrients().getCalorie().toString());
  print("fat "+tf.getNutrients().getFat().toString());
  print("car "+tf.getNutrients().getCarbohydrates().toString());
  print("sug "+tf.getNutrients().getSugar().toString());
  print("pro "+tf.getNutrients().getProtein().toString());

}