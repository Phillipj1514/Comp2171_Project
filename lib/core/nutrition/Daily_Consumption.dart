import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/nutrition/Food.dart';
import 'package:Vainfitness/core/nutrition/Nutrition_Data.dart';

class Daily_Consumption{
  /// The identifying date associated with the Daily Consumption Object
  /// In utf Year Month Day. 
  DateTime date = DateTime.now();
  /// Represents the list of Meals consumed within a given day. 
  List<Meal> meals = List<Meal>();
  /// The overal nutritional value of all meals presumed to be consumed 
  /// in a given day. 
  Nutrition_Data nutrition_data = new Nutrition_Data();

  // CONSTRUCTOR
  Daily_Consumption();
  Daily_Consumption.withDate(int year, int month, int day){
    this.date = new DateTime.utc(year, month, day);
  }


  // SETTER 
  ///  This calls the method 'calcTotalCalorie' to recompute the 
  /// caloric value of all the Daily Consumption after any modification to the list. 
  /// Once calculated, the totalCalorie attribute is updated.
  /// 
  /// Used when a modification of the list is done through 'addFoodItem' 
  /// or 'removeFoodItem', to update/preserve the total caloric count. 
  void updateTotalCalorie()=> this.nutrition_data.setCalorie(calcTotalCalorie());
  

  // GETTERS
  /// Retrieves the Date associated with a given consumption. 
  DateTime getDate()=> this.date;

  /// Retrieves the list of all meals in the consumption list for a given day. 
  List<Meal> getMeals()=>this.meals;

  /// Retrieves a specific meal in the list
  Meal getMeal(String id) => this.meals.firstWhere((Meal meal) => meal.getId() == id);

  /// Retrieves the caloric value presumed to have been consumed in a given day. 
  int getTotalCalVal() => this.nutrition_data.getCalorie();

  // MODIFIERS
  /// Used to add a Meal to the Consumption List.
  void addMeal(Meal meal){
    this.meals.add(meal);
    this.calcTotalCalorie();
  }

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
  int calcTotalCalorie(){
    int sumCalorieOfMeal = 0;
    for(var meal in meals){
      List<Food> foodsInMeal = meal.getFoods();
      foodsInMeal.forEach((food) {sumCalorieOfMeal += food.getCalorie();});
    }
    return sumCalorieOfMeal;    
  }  

  Map<String, dynamic> mapify(){
    return{
      "date":this.date,
      "meals":  [for (var meal in this.meals) meal.mapify()],
      "nutrition_details": this.nutrition_data.mapify()
    };
  }
  Daily_Consumption.fromMap(Map mapdata){
    this.date = new DateTime.fromMillisecondsSinceEpoch(mapdata["date"].millisecondsSinceEpoch);
    this.meals = [ for(var meal in mapdata["meals"]) new Meal.fromMap(meal)];
    this.nutrition_data = new Nutrition_Data.fromMap(mapdata["nutrition_details"]);
  }
}

/// unit test
void main(List<String> args) {
  Daily_Consumption tdc = new Daily_Consumption();
  print(tdc.getDate().toString());
  tdc.addMeal(new Meal());
  print(tdc.getMeals()[0].toString());
  print(tdc.getMeals()[0].getName());
  print(tdc.getTotalCalVal());
}
