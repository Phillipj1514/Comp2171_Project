import 'package:Vainfitness/core/nutrition/Meal.dart';


class MealPlan {
  //ATTRIBUTES

  /// The name given to the MealPlan. 
  /// By default is set to "Healthy Lifestyle".
  String name;

  /// The list of all the meals making up a MealPlan.
  List<Meal> meals;

  /// The duration in number of days the MealPlan will last. 
  /// By default set to 7 days. 
  int numDays; 

  /// A unique ID that is given to each MealPlan when created.
  String id;

  /// Used to enable autoincrement on assigning an ID to MealPlans
  static int mealPlanCnt = 0;

  //CONSTRUCTORS
  /// A MealPlan constructor that takes in a predefined list of Meals 
  /// and optionally sets the MealPlan's name and duration.
  MealPlan({this.name = "Healthy Lifestyle", this.numDays = 7, List<Meal> meals}){
    this.meals = meals;
    mealPlanCnt++;
    this.id = "mealplan_"+mealPlanCnt.toString();
  }

  /// A MealPlan constructor that initializes a Meal List while
  /// optionally setting a MealPlan's name and duration. If name and duration
  /// are not given. These attributes are set up with default values. 
  MealPlan.defaultConst({this.name = "Healthy Lifestyle", this.numDays = 7}){
    this.meals = [];
    this.id = "mealplan_"+mealPlanCnt.toString();
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
  /// Used to retrieve the id for the MealPlan
  String getId() => this.id;
  
  /// Used to retrieve the name of the MealPlan
  String getName()=> this.name;

  /// Used to get the meal at a particular index from the MealPlan List. 
  Meal getMeal(int index){
    try{
        Meal tmp = this.meals[index];
        return tmp;
    } on Exception catch(e){
      print('Exception details:\n $e');
    }
    return null;
  }

  /// Used to get all the Meals that make up the MealPlan
  List<Meal> getMealList()=> this.meals;

  /// Used to retrieve the duration the MealPlan will last.
  int getNumDays() => this.numDays;

  /// Gets the ID for the created MealPlan object. 
  String getMealPlanID() => this.id;


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

  Map<String, dynamic> mapify(){
    return{
      "id": this.id,
      "name": this.name,
      "num_days": this.numDays,
      "meals":[for(var meal in this.meals) meal.mapify()]
    };
  }
  MealPlan.fromMap(Map mapdata){
    this.id = mapdata["id"];
    this.name = mapdata["name"];
    this.numDays = mapdata["num_days"];
    this.meals = [for(var meal in mapdata["meals"]) new Meal.fromMap(meal)];
  }

}
// Unit testing
void main(List<String> args) {
  MealPlan tmpln = new MealPlan.defaultConst();
  print(tmpln.getMealPlanID());
   MealPlan tmpln2 = new MealPlan();
  print(tmpln2.getMealPlanID());
  print(tmpln.getName());
  print(tmpln.getNumDays());
  tmpln.addMeal(new Meal());
  print(tmpln.getMealList().length);
  tmpln.removeMealAt(0);
  print(tmpln.getMealList().length);
}