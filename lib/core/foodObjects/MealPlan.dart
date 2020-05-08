import 'package:Comp2171_Project/core/foodObjects/Meal.dart';


class MealPlan {
  //ATTRIBUTES
  String name;
  List<Meal> meals;
  int numDays; 
  int id;
  static int mealPlanID = 0;

  //CONSTRUCTORS
  /// A MealPlan constructor that takes in a predefined list of Meals 
  /// and optionally sets the MealPlan's name and duration.
  MealPlan(List<Meal> meals, {this.name = "Healthy Lifestyle", this.numDays = 7}){
    this.meals = meals;
    this.id = mealPlanID++;
  }

  /// A MealPlan constructor that initializes a Meal List while
  /// optionally setting a MealPlan's name and duration. If name and duration
  /// are not given. These attributes are set up with default values. 
  MealPlan.defaultConst({this.name = "Healthy Lifestyle", this.numDays = 7}){
    this.meals = [];
  }


  //SETTERS
  /// Used to give a name to a MealPlan.
  void setName(String name){
    this.name = name;
  }

  /// Used to set the duration of the MealPlan. 
  void setNumDays(int days){
    this.numDays = days;
  }

  //GETTERS
  /// Used to retrieve the name of the MealPlan
  String getName()=> this.name;

  /// Used to get the meal at a particular index from the MealPlan List. 
  Meal getMeal(int index)=> this.meals[index];

  /// Used to get all the Meals that make up the MealPlan
  List<Meal> getMealList()=> this.meals;

  /// Used to retrieve the duration the MealPlan will last.
  int getNumDays() => this.numDays;

  /// Gets the ID for the created MealPlan object. 
  int getMealPlanID() => this.id;


  //MODIFIER
  /// Removes a meal from the MealPlan List given a particular index.
  void removeMealAt(int index){
    try{
      meals.removeAt(index);
    }catch(e,s){
      print("$e \n $s");
    }
  }

  /// Removes a meal from the MealPlan List given a particular Meal.
  void removeMeal(Meal meal){
    try{
      meals.remove(meal);
    }catch(e,s){
      print("$e \n $s");
    }
  }

  /// Used to add a Meal to the MealPlan List.
  void addMeal(Meal meal) {
    meals.add(meal);
  }

}