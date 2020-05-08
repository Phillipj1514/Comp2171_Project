import 'package:Comp2171_Project/core/foodObjects/Food.dart';

void main(){
  Meal testMeal = Meal("lunch", "having", 500.0);
}

class Meal {
  //ATTRIBUTES
  String name; 
  List<Food> foods;
  String method;
  double totalCalorie;

  // CONSTRUCTOR
  /// This constructs a Meal Object with optional attributes 
  /// of Meal Name, method, and a total caloric value for the meal.
  Meal([this.name, this.method, this.totalCalorie]){
    this.foods = [];
  }

  //SETTERS
  /// Used to give the Meal Object a name.
  void setName(String name){
    this.name = name;
  }

  /// Used to set the method which the object will call on itself.
  void setMethod(String method){
    this.method = method;
  }

  /// This allows an update of the Meal's total calories 
  /// given a caloric value. 
  void setTotalCalorie(double calorie){
    this.totalCalorie = calorie;
  }

  ///  This calls the method 'calcTotalCalorie' to recompute the 
  /// caloric value of all the Food items in the Food List. 
  /// Once calculated, the totalCalorie attribute is updated.
  /// Used when a modification of the list is done through 'addFoodItem' 
  /// or 'removeFoodItem', to update/preserve the total caloric count. 
  void updateTotalCalorie(){
    this.totalCalorie = calcTotalCalorie();
  }

  
  //GETTERS
  /// Allows the Meal name to be retrieved 
  String getName()=>this.name;

  /// Retrieves the food  at a particular index in the Food List.
  Food getFoodItemAt(int index)=> foods[index];

  /// Retrieves the food object from the Food List.
  Food getFoodItem(int index)=> foods[index];

  /// Retrieves the list consisting of all the foods that make up a meal.
  List<Food> getFoods()=> foods;

  /// Used to indicate the method which called the object on object creation.
  String getMethod()=> this.method;

  /// Used to retrieve the total caloric value of the Meal object. 
  double getTotalCalorie()=>this.totalCalorie;


  
  //MODIFIERS
  /// Allows a food item to be added to the Food List which constitutes the Meal.
  void addFoodItem(Food foodItem){
    foods.add(foodItem);
    //updateTotalCalorie();
  }

  /// Allows a Food Object to be removed from a particular index in the Food List.
  void removeFoodAt(int index){
    try{
      foods.removeAt(index);
      //updateTotalCalorie();
    }catch(e,s){
      print("$e \n $s");
    }
  }

  /// Allows a Food Object to be removed from the Food List
  void removeFood(Food fitem){
    try{
      foods.remove(fitem);
      //updateTotalCalorie();
    }catch(e,s){
      print("$e \n $s");
    }
  }

  /// Computes the total caloric value of all the food items that make up the Food List (which constitutes the Meal).
  double calcTotalCalorie(){
    double sumCalorieOfMeal;
    foods.forEach((foodItem) {sumCalorieOfMeal += foodItem.calorie;});
    return sumCalorieOfMeal;    
  }
}