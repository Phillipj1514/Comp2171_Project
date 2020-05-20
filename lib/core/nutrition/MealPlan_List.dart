import 'package:Vainfitness/core/nutrition/MealPlan.dart' show MealPlan;

class MealPlan_List {
  // ATTRIBUTES
  static List<MealPlan> mealPlanLst = [];

  //GETTERS
  /// Allows a MealPlan to be retieved from the MealPlan List given the ID of the MealPlan.
  static MealPlan getMealPlanByID(String planId){
    try{
      MealPlan gotit = mealPlanLst.firstWhere((MealPlan mealPlan) => mealPlan.getId() == planId);
      return gotit;
    }catch(e){
      print(e.toString());
      print("No such MealPlan exists, ERROR!");
      return null;
    }
  }
    
  /// Allows a MealPlan to be retieved from the MealPlan List given the name of the MealPlan.
  static MealPlan getMealPlanByName(String planName){
    try{
      MealPlan gotit = mealPlanLst.firstWhere((MealPlan mealPlan) => mealPlan.getName() == planName);
      return gotit;
    }catch(e){
      print(e.toString());
      print("No such MealPlan exists, ERROR!");
      return null;
    }
  }

  /// get mealplan by the index
  static MealPlan getMealPlan(int index){
    try{
      MealPlan gotit = mealPlanLst[index];
      return gotit;
    }catch(e){
      print(e.toString());
      print("No such MealPlan exists, ERROR!");
      return null;
    }
  }

  /// Gives the number of plans created. 
  static int getPlanCount()=> mealPlanLst.length;

  // SETTERS

  // set the meal plan list
  static void setMealPlanList(List<MealPlan> mealPlans) => mealPlanLst = mealPlans;

  // MODIFIERS
  /// Allows a MealPlan Object to be added to the MealPlan List.
  static void addMealPlan(MealPlan mPlan){
    mealPlanLst.add(mPlan);
  }

  /// Update and existing MealPlan in the list
  static void updateMealPlan(MealPlan mealPlan){
    try{
      print("--> Updating a meal plan object");
      int index = mealPlanLst.indexWhere((MealPlan mealplan) => mealplan.getId() == mealPlan.getId());
      if(index == -1){
        print("mealplan doesnt exist adding it instead");
        MealPlan_List.addMealPlan(mealPlan);
      }else{
        mealPlanLst[index] = mealPlan;
      }
    }catch(e){
      print(e.toString());
    }
  }

  /// Allows a mealPlan to be removed  given the mealPlan Object.
  static void removeMealPlan(MealPlan mealplan){
    try{
      mealPlanLst.remove(mealplan);
    }catch(e){
      print(e.toString());
      print("No such MealPlan");
    }
  }

  /// Allows a mealPlan to be removed from the MealPlan List given a particular index.
  static void removeMealPlanAt(int index){
    try{
      mealPlanLst.removeAt(index);
    }catch(e){
      print(e.toString());
      print("No such MealPlan");
    }
  }

  /// Allows a mealPlan to be removed from the MealPlan List given the name of the MealPlan.
  static void removeMealPlanByName(String mealplanName){
    try{
      mealPlanLst.forEach((mealplan) {if(mealplan.getName() == mealplanName){mealPlanLst.remove(mealplan);}});
    }catch(e){
      print(e.toString());
      print("No such MealPlan");
    }
  }

  /// Allows a mealPlan to be removed from the MealPlan List given the id of the MealPlan.
  static void removeMealPlanById(String mealPlanId){
    try{
      mealPlanLst.removeWhere((MealPlan mealPlan) => mealPlan.getId() == mealPlanId);
    }catch(e){
      print(e.toString());
      print("No such MealPlan");
    }
  }

}
// Unit testing
void main(List<String> args) {
  MealPlan_List.addMealPlan(new MealPlan.noMeals());
  MealPlan_List.addMealPlan(new MealPlan.noMeals());
  print(MealPlan_List.getPlanCount());
  MealPlan_List.removeMealPlanAt(0);
  print(MealPlan_List.getPlanCount());
}