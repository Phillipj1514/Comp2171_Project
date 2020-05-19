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
  Daily_Consumption.dateTime(this.date);


  // SETTER 
  ///  This is done to update the day's total nutrition values 
  /// from all the meals that are in the system 
  void updateNutritionData(){
    Nutrition_Data nutrition_data = new Nutrition_Data();
    for(Meal meal in this.meals){
      Nutrition_Data mealNutri = meal.getTotalNutrients();
      nutrition_data.addAll(mealNutri.getCalorie(), mealNutri.getFat(), mealNutri.getCarbohydrates(), 
        mealNutri.getSugar(), mealNutri.getProtein()); 
     }
    this.nutrition_data = nutrition_data;
  } 

  // GETTERS
  /// Retrieves the Date associated with a given consumption. 
  DateTime getDate()=> this.date;

  /// Retrieves the list of all meals in the consumption list for a given day. 
  List<Meal> getMeals()=>this.meals;

  /// Retrieves a specific meal in the list
  Meal getMeal(String id){
    try{
        return this.meals.firstWhere((Meal meal) => meal.getId() == id);
    }catch(e){
      print(e.toString());
      print("no such meal");
      return null;
    }
  }

  /// Retrieves the nutrients value presumed to have been consumed in a given day. 
  Nutrition_Data getTotalNutrients() => this.nutrition_data;

  // MODIFIERS
  /// Add the nutrition given value to the toal available values stored
  void addNutritionData(Nutrition_Data nutriData){
    this.nutrition_data.addAll(nutriData.getCalorie(), nutriData.getFat(), nutriData.getCarbohydrates(), 
        nutriData.getSugar(), nutriData.getProtein()); 
  } 
  
  /// Used to add a Meal to the Consumption List.
  void addMeal(Meal meal){
    this.meals.add(meal);
    this.addNutritionData(meal.getTotalNutrients());
  }
  
  /// Allows a meal within the consumprion list 
  ///to be replaced with an updated meal.
  void updateMeal (int index, Meal newMeal){ 
    try{
      meals[index] = newMeal;
    }catch(e){
      print(e.toString());
      print("meal wasnt updated");
    }
  }
  
  void updateMeal2 (Meal newMeal){ 
    try{
      String id = newMeal.getId();
      Meal oldMeal = this.getMeal(id);
      if(oldMeal != null){
        int index = meals.indexOf(oldMeal);
        this.meals[index] = newMeal;
      }else{
        print("meal wasnt updated");
      }
    }catch(e){
      print(e.toString());
      print("meal wasnt updated");
    }
  }

  /// Removes a meal from the Consumption List given a particular index.
  void removeMealAt(int index){
    try{
      meals.removeAt(index);
    }catch(e){
      print(e.toString());
    }
  }

  /// Removes a meal from the Consumption List given a particular Meal.
  void removeMeal(Meal meal){
    try{
      meals.remove(meal);
    }catch(e){
      print(e.toString());
      print("meal doesnt exists");
    }
  }

  /// Removes a meal from the Consumption List given a particular id.
  void removeMealWithID(String id){
    try{
      meals.removeWhere((Meal meal) => meal.getId() == id);
    }catch(e){
      print(e.toString());
      print("meal doesnt exists");
    }
  }

  /// Removes a meal from the Consumption List given a particular id.
  void removeMealWithMealPlanId(String mealPlanid){
    try{
      meals.removeWhere((Meal meal) => (meal.getMealPlanId() == mealPlanid && meal.isFromMealPlan() == true));
    }catch(e){
      print(e.toString());
      print("meal from mealplan doesnt exists");
    }
  }

  // LOGIC 

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
  print(tdc.getMeals()[0].getId());
  print(tdc.getTotalNutrients().getCalorie());
  // Testing troublesome methods
  print(tdc.getMeal("meal_2").toString());
  Meal badmeal = new Meal();
  tdc.updateMeal2(badmeal);
  tdc.updateNutritionData();
}
