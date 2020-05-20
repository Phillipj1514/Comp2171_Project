import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class MealPlanManager{
  
  static DatabaseManager db = DatabaseManager();

  /// Get all the mealplans that a client subscribes to 
  static Future<List> getClientMealPlanSubscriptions()async{
    try{
      print("--> getting user mealplan subscription");
      if(ProfileManager.isClient()){
        Client client =  ProfileManager.getUser();
        List<String> clientMealPlanSubs = client.getMealPlanSubscriptions();
        List<MealPlan> mealPlanSubscriptions = [];
        if(MealPlan_List.mealPlanLst == null || MealPlan_List.mealPlanLst == []){
          await MealPlanManager.loadMealPlanList();
        }
        clientMealPlanSubs.forEach((mealPlanId) { 
          MealPlan mealPlan = MealPlan_List.getMealPlanByID(mealPlanId);
          if(mealPlan != null){
            mealPlanSubscriptions.add(mealPlan);
          }
        });
        return mealPlanSubscriptions;
      }else{print("Only clients have meal plan subscription");}
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Add MealPlan the the clients mealPlan subscriptions
  static Future addUserMealPlanSubscription(DateTime startTime ,String mealPlanId) async{
    try{
      print("--> adding user mealplan subscription");
      if(ProfileManager.isClient()){
        Client client = ProfileManager.getUser();
        if(MealPlan_List.mealPlanLst == null || MealPlan_List.mealPlanLst == []){
          await MealPlanManager.loadMealPlanList();
        }
        MealPlan mealPlan = MealPlan_List.getMealPlanByID(mealPlanId);
        client.addMealPlanToConsumptions(startTime, mealPlan);
        await db.updateUser(client);
        ProfileManager.setUser(client);
      }
    }catch(e){
      print(e.toString());
    }
  }
  
  // Remove a mealPlan from Clients subscription
  static Future removeUserMealPlanSubscription(String mealPlanId) async{
    try{
      print("--> removing user mealplan subscription");
      if(ProfileManager.isClient()){
        Client client = ProfileManager.getUser();
        if(MealPlan_List.mealPlanLst == null || MealPlan_List.mealPlanLst == []){
          await MealPlanManager.loadMealPlanList();
        }
        client.removeMealPlanFromConsumption(mealPlanId);
        await db.updateUser(client);
        ProfileManager.setUser(client);
      }
    }catch(e){
      print(e.toString());
    }
  }

  /// Load the meal plans from the dataabse into the application
  static Future loadMealPlanList() async{
    try{
      print("--> Loading Mealplans from database");
      List<MealPlan> mealPlans = await db.fetchMealPlans();
      MealPlan_List.setMealPlanList(mealPlans);
    }catch(e){
      print(e.toString());
    }
  }
  
  /// Adds the given meal plan to the list of mealplans should only be used by the admin
  static Future addMealPlan(MealPlan mealplan) async{
    try{
      if(ProfileManager.isFitnessCoach()){
        print("--> Adding Mealplan to list of meal plans");
        if(mealplan != null){
          if(MealPlan_List.mealPlanLst == null || MealPlan_List.mealPlanLst == []){
            await MealPlanManager.loadMealPlanList();
          }
          await db.addNewMealPlan(mealplan);
          MealPlan_List.addMealPlan(mealplan);
        }else{print("Invalid mealplan submitted");}
      }else{ print("Only coaches can add mealplan");}
    }catch(e){
      print(e.toString());
    }
  }

  // Remove a meal Plan given the meal plan id
  static Future deleteMealPlan(String  mealPlanId) async{
    try{
      if(ProfileManager.isFitnessCoach()){
        print("--> deleting Mealplan to list of meal plans");
        if(MealPlan_List.mealPlanLst == null || MealPlan_List.mealPlanLst == []){
          await MealPlanManager.loadMealPlanList();
        }
        await db.deleteMealPlan(mealPlanId);
        MealPlan_List.removeMealPlanById(mealPlanId);
      }else{ print("Only coaches can add mealplan");}
    }catch(e){
      print(e.toString());
    }
  }

  // update a meal Plan given the meal plan
  static Future updateMealPlan(MealPlan  mealPlan) async{
    try{
      if(ProfileManager.isFitnessCoach()){
        print("--> updating Mealplan to list of meal plans");
        if(MealPlan_List.mealPlanLst == null || MealPlan_List.mealPlanLst == []){
          await MealPlanManager.loadMealPlanList();
        }
        await db.updateMealPlan(mealPlan);
        MealPlan_List.updateMealPlan(mealPlan);
      }else{ print("Only coaches can add mealplan");}
    }catch(e){
      print(e.toString());
    }
  }

}