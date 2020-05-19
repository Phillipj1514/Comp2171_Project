import 'package:Vainfitness/core/nutrition/Food.dart';
import 'package:Vainfitness/core/nutrition/Nutrition_Data.dart';

class Meal {
  //ATTRIBUTES

  ///counting variable for the meals
  static int cnt = 1;

  /// The id given to the meal. set automatically
  String id;

  /// The name given to a meal. By default is set to "meal".
  String name; 

  /// The list of all the foods making up a Meal.
  List<Food> foods;

  /// The method.
  String method;

  /// The overal nutritional value of a meal. By default is set to 0.0.
  Nutrition_Data nutrition_data = new Nutrition_Data();

  // Attribute for meals apart of Meal Plan
  /// boolean to check if the meal is from a meal plan 
  bool fromMealPlan = false;

  /// mealplan id if its from meal plan
  String mealPlanId = "";

  // CONSTRUCTOR
  /// This constructs a Meal Object with optional attributes 
  /// of Meal Name, method, and a total caloric value for the meal.
  Meal({this.name = 'meal', this.method = "Prepare the meal as fit"}){
    this.foods = [];
    this.id = "meal_"+cnt.toString();
    Meal.cnt++;
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

  ///  This is done to update the day's total nutrition values 
  /// from all the meals that are in the system 
  void updateNutritionData(){
    Nutrition_Data nutrition_data = new Nutrition_Data();
    for(Food food in this.foods){
      Nutrition_Data foodNutri = food.getNutrients();
      nutrition_data.addAll(foodNutri.getCalorie(), foodNutri.getFat(), foodNutri.getCarbohydrates(), 
        foodNutri.getSugar(), foodNutri.getProtein()); 
     }
    this.nutrition_data = nutrition_data;
  } 

  /// set the count variable for hte meal ids
  static void setCount(int cnt) => Meal.cnt = cnt;
  
  /// set the boolean to check if its from a meal plan
  void changeIsFromMealPlan(bool fromMealPlan) => this.fromMealPlan = fromMealPlan;

  /// check the mealplan assigned id
  void setMealPlanId(String mealPlanId) => this.mealPlanId = mealPlanId;

  //GETTERS

  ///get the total meals cnt in the system
  static int getMealCount() => Meal.cnt;
  
  ///Retrieved the meal id
  String getId() => this.id;

  /// Allows the Meal name to be retrieved 
  String getName()=>this.name;
  
  /// Retrieves the food object from the Food List.
  Food getFoodItem(int index){
    try{
      return foods[index];
    }catch(e){
      print(e.toString());
      print("no food item found");
      return null;
    }
  }

  /// Retrieves the list consisting of all the foods that make up a meal.
  List<Food> getFoods()=> this.foods;

  /// Used to indicate the method which called the object on object creation.
  String getMethod()=> this.method;

  /// Get nutirition data object
  Nutrition_Data getTotalNutrients() => this.nutrition_data;

  /// Retrieves the number of food items that make up the meal
  int getFoodCount()=> foods.length;

  /// Get the boolean to check if its from a meal plan
  bool isFromMealPlan() => this.fromMealPlan;

  /// Get the mealPlan Id that its assigned to
  String getMealPlanId() => this.mealPlanId;

  //MODIFIERS
  /// Add the nutrition given value to the toal available values stored
  void addNutritionData(Nutrition_Data nutriData){
    this.nutrition_data.addAll(nutriData.getCalorie(), nutriData.getFat(), nutriData.getCarbohydrates(), 
        nutriData.getSugar(), nutriData.getProtein()); 
  } 
  
  /// Allows a food item to be added to the Food List which constitutes the Meal.
  Future<void> addFoodItem(Food foodItem) async{
    try{
      await foodItem.updateNutritionalDetail();
      foods.add(foodItem);
      this.addNutritionData(foodItem.getNutrients());
    }catch(e){
      print(e.toString());
    }
  }

  /// Allows a Food Object to be removed from a particular index in the Food List.
  void removeFoodAt(int index){
    try{
      foods.removeAt(index);
      //updateTotalCalorie();
    }catch(e){
     print(e.toString());
    }
  }

  /// Allows a Food Object to be removed from the Food List
  void removeFood(Food fitem){
    try{
      foods.remove(fitem);
      //updateTotalCalorie();
    }catch(e){
      print(e.toString());
    }
  }

  // Database Manager methods 
  Map<String, dynamic> mapify(){
    return{
      "id":this.id,
      "name": this.name,
      "method": this.method,
      "foods":  [for (var food in this.foods) food.mapify()],
      "nutrition_details": this.nutrition_data.mapify(),
      "fromMealPlan": this.fromMealPlan,
      "mealPlanID": this.mealPlanId
    };
  }
  
  Meal.fromMap(Map mapdata){
    this.id = mapdata["id"];
    this.name = mapdata["name"];
    this.method = mapdata["method"];
    this.foods = [for (var food in mapdata["foods"]) new Food.fromMap(food)];
    this.nutrition_data = new Nutrition_Data.fromMap(mapdata["nutrition_details"]);
    this.fromMealPlan = mapdata["fromMealPlan"];
    this.mealPlanId = mapdata["mealPlanID"];
  }
}

// unit testing
void main(List<String> args) async{
  Meal tml = new Meal();
  print(tml.getId().toString());
  print(tml.getName());
  await tml.addFoodItem(new Food(name:"beef", quantity: 1));
  print(tml.getTotalNutrients().getCalorie());
  print(tml.getMethod());
  Meal tml2 = new Meal();
  print(tml2.getId().toString());
  tml.getFoodItem(2);
}