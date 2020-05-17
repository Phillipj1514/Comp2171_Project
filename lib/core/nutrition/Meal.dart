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

  /// This allows an update of the Meal's total calories 
  /// given a caloric value. 
  void setTotalCalorie(int calorie){
    this.nutrition_data.setCalorie(calorie);
  }

  ///  This calls the method 'calcTotalCalorie' to recompute the 
  /// caloric value of all the Food items in the Food List. 
  /// Once calculated, the totalCalorie attribute is updated.
  /// Used when a modification of the list is done through 'addFoodItem' 
  /// or 'removeFoodItem', to update/preserve the total caloric count. 
  void updateTotalCalorie(){
    this.nutrition_data.setCalorie(calcTotalCalorie());
  }

  
  //GETTERS

  //Retrieved the meal id
  String getId() => this.id;

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
  int getTotalCalorie()=>this.nutrition_data.getCalorie();

  /// Retrieves the number of food items that make up the meal
  int getFoodCount()=> foods.length;

  
  //MODIFIERS
  /// Allows a food item to be added to the Food List which constitutes the Meal.
  Future<void> addFoodItem(Food foodItem) async{
    await foodItem.updateCalorie();
    foods.add(foodItem);
    updateTotalCalorie();
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
  int calcTotalCalorie(){
    int sumCalorieOfMeal = 0;
    foods.forEach((foodItem) {sumCalorieOfMeal += foodItem.getCalorie();});
    return sumCalorieOfMeal;    
  }
}

// unit testing
void main(List<String> args) async{
  Meal tml = new Meal();
  print(tml.getId().toString());
  print(tml.getName());
  await tml.addFoodItem(new Food(name:"beef", quantity: 1));
  print(tml.getTotalCalorie());
  print(tml.getMethod());
  Meal tml2 = new Meal();
  print(tml2.getId().toString());
}