import 'package:Comp2171_Project/core/util/Calorie_manager.dart';

enum Measure{number, weight}
class Food{
  String name;
  double quantity = 0;
  Measure measure;
  int calorie = 0;
  double fat = 0;
  double carbohydrates = 0;
  double sugar = 0;
  double protein = 0;
  Calorie_Manager calorie_manager = new Calorie_Manager();

  Food(this.name, this.quantity, String measure){
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
  int getCalorie() => this.calorie;
  double getFat() => this.fat;
  double getCarbohydrates() => this.carbohydrates;
  double getSugar() => this.sugar;
  double getProtein() => this.protein;

  // Setters
  void setName(String name) => this.name = name;
  void setQuantity(double quantity) => this.quantity = quantity;
  void  setMeasure(String measure){
    this.measure = measure == "NUMBER" ? Measure.number : Measure.weight;
  }

  // Modifiers
  Future<void> updateCalorie() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await calorie_manager.queryFood(food);
    this.calorie = calorie_manager.extractCalorie(foodData);
  }

  Future<void> updateFat() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await calorie_manager.queryFood(food);
    this.fat = calorie_manager.extractFat(foodData);
  }

  Future<void> updateCarbohydrates() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await calorie_manager.queryFood(food);
    this.carbohydrates = calorie_manager.extractCarbohydrate(foodData);
  }

  Future<void> updateSugar() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await calorie_manager.queryFood(food);
    this.sugar = calorie_manager.extractSugar(foodData);
  }

  Future<void> updateProtein() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await calorie_manager.queryFood(food);
    this.protein = calorie_manager.extractProtien(foodData);
  }

  Future<void> updateNutritionalDetail() async{
    String food = this.quantity.toString()+" "+this.name;
    var foodData = await calorie_manager.queryFood(food);
    this.calorie = calorie_manager.extractCalorie(foodData);
    this.fat = calorie_manager.extractFat(foodData);
    this.carbohydrates = calorie_manager.extractCarbohydrate(foodData);
    this.sugar = calorie_manager.extractSugar(foodData);
    this.protein = calorie_manager.extractProtien(foodData);

  }


}

void main(List<String> args) async{
  Food tf = new Food("apple",1,"NUMBER");
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