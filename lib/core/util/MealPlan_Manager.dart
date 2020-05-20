import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class MealPlanManager{
  
  static DatabaseManager db = DatabaseManager();

  static Future<List> getClientMealPlanSubscriptions(ProfileManager profileManager)async{
    try{
      if(profileManager.isClient()){
        Client client =  profileManager.getUser();
        List<String> clientMealPlanSubs = client.getMealPlanSubscriptions();
        List<MealPlan> mealPlanSubscriptions = [];
        MealPlanManager.updateMealPlanList();
        clientMealPlanSubs.forEach((mealPlanId) { 
          MealPlan mealPlan = MealPlan_List.getMealPlanByID(mealPlanId);
          if(mealPlan != null){
            mealPlanSubscriptions.add(mealPlan);
          }
        });
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future updateMealPlanList() async{
    try{
      List<MealPlan> mealPlans = await db.fetchMealPlans();
      MealPlan_List.setMealPlanList(mealPlans);
    }catch(e){
      print(e.toString());
    }
  }
}