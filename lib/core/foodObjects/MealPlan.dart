import 'package:Comp2171_Project/core/foodObjects/Meal.dart';


class MealPlan {
  String name;
  List<Meal> meals;
  int numDays; 

  MealPlan(this.name, List<Meal> meals, this.numDays){
    this.meals = List<Meal>();
  }

  //SETTERS
  void setName(String name){
    this.name = name;
  }

  void addMeal(Meal meal) {
    meals.add(meal);
  }


  //GETTERS
  String getName()=> this.name;

  Meal getMeal(int index)=> this.meals[index];

  List<Meal> getMeals()=> this.meals;

  int getNumDays() => this.numDays;


  //MODIFIER
  void removeMeal(int index){
    try{
      meals.removeAt(index);
    }catch(e,s){
      print("$e \n $s");
    }
  }

  // bool removeMeal(int index){
    //var check = meals[index];
    //meals.removeAt(index);
    //if(!meals.contains(check)){
      //return true;
    //}else{
      //return false;
    //}
    

  

}