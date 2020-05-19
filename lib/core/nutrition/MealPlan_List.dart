import 'package:Vainfitness/core/nutrition/MealPlan.dart' show MealPlan;

class MealPlan_List {
  // ATTRIBUTES
  static List<MealPlan> mealPlanLst = [];

  //CONSTRUCTOR
  /// Builds a MealPlan List object which consist of a list containing all created MealPlans. 
  MealPlan_List(){
    // Initializing dynamic list.
  }


  //GETTERS
  /// Allows a MealPlan to be retieved from the MealPlan List given the ID of the MealPlan.
  MealPlan getMealPlanByID(int planID){
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
  MealPlan getMealPlanByName(String planName){
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

  /// get mealplan by the index
  MealPlan getMealPlan(int index){
    try{
        mealPlanLst.removeAt(index);
    } on Exception catch(e){
      print('Exception details:\n $e');
    }
  }

  /// Gives the number of plans created. 
  int getPlanCount()=> mealPlanLst.length;

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
      mealPlanLst.removeAt(index);
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
// Unit testing
void main(List<String> args) {
  MealPlan_List tmpl = new MealPlan_List();
  tmpl.addMealPlan(new MealPlan.defaultConst());
  tmpl.addMealPlan(new MealPlan.defaultConst());
  print(tmpl.getPlanCount());
  tmpl.removeMealPlanAt(0);
  print(tmpl.getPlanCount());
}