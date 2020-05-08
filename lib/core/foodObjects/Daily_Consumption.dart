import 'package:Comp2171_Project/core/foodObjects/Meal.dart';
import 'package:Comp2171_Project/core/foodObjects/Food.dart';

class Daily_Consumption{
  /// The identifying date associated with the Daily Consumption Object
  /// In utf Year Month Day. 
  DateTime date;
  /// Represents the list of Meals consumed within a given day. 
  List<Meal> meals;
  /// The overal caloric value of all meals presumed to be consumed 
  /// in a given day. 
  double totalCalorie;

  // CONSTRUCTOR
  Daily_Consumption(int year, int month, int day){
    this.date = new DateTime.utc(year, month, day);
    this.meals = List<Meal>();
  }

  // SETTER 
  ///  This calls the method 'calcTotalCalorie' to recompute the 
  /// caloric value of all the Daily Consumption after any modification to the list. 
  /// Once calculated, the totalCalorie attribute is updated.
  /// 
  /// Used when a modification of the list is done through 'addFoodItem' 
  /// or 'removeFoodItem', to update/preserve the total caloric count. 
  void updateTotalCalorie()=> this.totalCalorie = calcTotalCalorie();
  

  // GETTERS
  /// Retrieves the Date associated with a given consumption. 
  DateTime getDate()=> this.date;

  /// Retrieves the list of all meals in the consumption list for a given day. 
  List<Meal> getMeals()=>this.meals;

  /// Retrieves the caloric value presumed to have been consumed in a given day. 
  double getTotalCalValForDay() => this.totalCalorie;

  // MODIFIERS
  /// Used to add a Meal to the Consumption List.
  void addMeal(Meal meal) =>  meals.add(meal);

  /// Allows a meal within the consumprion list 
  ///to be replaced with an updated meal.
  void updateMeal (int index, Meal newMeal)=> meals[index] = newMeal;

  /// Removes a meal from the Consumption List given a particular index.
  void removeMealAt(int index){
    try{
      meals.removeAt(index);
    }catch(e,s){
      print("$e \n $s");
    }
  }

  /// Removes a meal from the Consumption List given a particular Meal.
  void removeMeal(Meal meal){
    try{
      meals.remove(meal);
    }catch(e,s){
      print("$e \n $s");
    }
  }

  // LOGIC 
  /// Computes the total caloric value of all the food items that make up the Food List (which constitutes the Meal).
  double calcTotalCalorie(){
    double sumCalorieOfMeal;
    for(var meal in meals){
      List<Food> foodsInMeal = meal.getFoods();
      foodsInMeal.forEach((food) {sumCalorieOfMeal += food.getCalorie();});
    }
    return sumCalorieOfMeal;    
  }  
}