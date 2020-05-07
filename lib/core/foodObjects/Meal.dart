import 'package:Comp2171_Project/core/foodObjects/Food.dart';

void main(){
  Meal testMeal = Meal("lunch", "having", 500.0);
}

class Meal {
  String name; 
  List<Food> foods;
  String method;
  double totalCalorie;

  Meal(this.name, this.method, this.totalCalorie){
    this.foods = List<Food>();
    print("set meal up sis");
  }

  //SETTERS
  void setName(String name){
    this.name = name;
  }

  void setMethod(String method){
    this.method = method;
  }

  void setTotalCalorie(double calorie){
    this.totalCalorie = calorie;
  }

  
  //GETTERS
  String getName()=>this.name;

  Food getFoodItem(int index)=> foods[index];

  List<Food> getFoods()=> foods;

  String getMethod()=> this.method;

  double getTotalCalorie() => this.totalCalorie;

  
  //MODIFIERS
  void addFoodItem(Food foodItem){
    foods.add(foodItem);
  }

  void removeFoodItem(int index){
    try{
      foods.removeAt(index);
    }catch(e,s){
      print("$e \n $s");
    }
  }



}