import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';

class MealPlan_Manager{
  Fitness_Coach coach; 
  MealPlan mealP;

  MealPlan_Manager(this.coach, this.mealP);

  void addMealPlan(Fitness_Coach fcoach, MealPlan mplan)=>  this.mealP = mplan;

}