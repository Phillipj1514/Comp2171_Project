import 'package:Comp2171_Project/core/foodObjects/MealPlan.dart';
import 'package:Comp2171_Project/core/foodObjects/Food.dart';


class MealPlan_List {
  // ATTRIBUTES
  List<MealPlan> mealPlanLst; 
  int numMealPlan;
  

  //CONSTRUCTOR
  /// Builds a MealPlan List object which consist of a list containing all created MealPlans. 
  MealPlan_List({this.numMealPlan = 1}){
    this.mealPlanLst = [];
  }


  //GETTERS
  /// Allows a MealPlan to be retieved from the MealPlan List given the ID of the MealPlan.
  MealPlan getMealPlanThroughID(int planID){
    MealPlan gotit;
    flow :for(var plan in mealPlanLst){
      if(plan.getMealPlanID() == planID){
        gotit = plan;
        break flow;
      }else{
        print("No such MealPlan exists, ERROR!");
      }
    }
    return gotit;
  }
    
  /// Allows a MealPlan to be retieved from the MealPlan List given the name of the MealPlan.
  MealPlan getMealPlanThroghName(String planName){
    MealPlan gotit;
    flow:for(var plan in mealPlanLst){
      if(plan.getName() == planName){
        gotit = plan;
        break flow;
      }else{
        print("No such MealPlan exists, ERROR!");
      }
    }
    return gotit;
  } 

  // MODIFIERS
  /// Allows a MealPlan Object to be added to the MealPlan List.
  void addMealPlan(MealPlan mPlan){
    mealPlanLst.add(mPlan);
  }

  /// Allows a mealPlan to be removed  given the mealPlan Object.
  void removeMealPlan(MealPlan mealplan){
    try{
      mealPlanLst.remove(mealplan);
    } catch(e, s){
      print("$e \n $s");
    }
  }

    /// Allows a mealPlan to be removed from the MealPlan List given a particular index.
  void removeMealPlanAt(int index){
    try{
      mealPlanLst.remove(index);
    } catch(e, s){
      print("$e \n $s");
    }
  }

    /// Allows a mealPlan to be removed from the MealPlan List given the name of the MealPlan.
  void removeMealPlanThroughName(String mealplanName){
    try{
      mealPlanLst.forEach((mealplan) {if(mealplan.getName() == mealplanName){mealPlanLst.remove(mealplan);}});
    } catch(e, s){
      print("$e \n $s");
    }
  }

}