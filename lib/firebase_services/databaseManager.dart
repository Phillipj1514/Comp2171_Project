import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';
import "package:cloud_firestore/cloud_firestore.dart";
/// This class aims on being an interface between the database and the application processes 
/// It provides the CRUD functions and serialization for the application objects to the databse
class DatabaseManager{
  final CollectionReference userCollection = Firestore.instance.collection("users");
  final CollectionReference mealPlanCollection = Firestore.instance.collection("mealplans");

  // document creation for each object or table creation for reg database
  Future addNewUser(User_Profile user) async{
    return await userCollection.document(user.getUid()).setData(user.mapify());
  }
  
  Future addNewMealPlan(MealPlan mealplan) async{
    return await mealPlanCollection.document(mealplan.getId()).setData(mealplan.mapify());
  }

  Future addNewDailyConsumption(Daily_Consumption daily_consumption, String uid) async{
    return await userCollection.document(uid).updateData({"daily_consumptions": FieldValue.arrayUnion([daily_consumption.mapify()])});

  }
  
  Future addNewMeal(Meal meal, String uid, DateTime consumptionID) async{
    try{
      var data = await userCollection.document(uid).get();
      Map dbdata = data.data;
      List consumps = [for(var cons in dbdata["daily_consumptions"]) new Daily_Consumption.fromMap(cons)];
      // try to fetch the specific daily consumption and remove it
      Daily_Consumption consump = consumps.firstWhere((dcons) => dcons.getDate() == consumptionID);
      await userCollection.document(uid).updateData({
        "daily_consumptions":FieldValue.arrayRemove([consump.mapify()])
        });
      // update the consumption with the meal then re add it to the list
      consump.addMeal(meal);
      return await userCollection.document(uid).updateData({
        "daily_consumptions":FieldValue.arrayUnion([consump.mapify()])
        });
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Data retreival for each objects
  Future fetchUser(String uid) async{
    try{
      var data = await userCollection.document(uid).get();
      var map = data.data;
      if(map["type"] == "client"){
        print("--> fetching client");
        return new Client.fromMap(map);
      }else if(map["type"] == "coach"){
        print("--> fetching coach");
        return new Fitness_Coach.fromMap(map);
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future fetchMealPlans() async{
    var data = await mealPlanCollection.snapshots();
    QuerySnapshot  querysnapshot = await data.first;
    List<MealPlan> mealplans = [];
    querysnapshot.documents.forEach((mealplan) { 
      mealplans.add(new MealPlan.fromMap(mealplan.data));
    });
    return mealplans;
  }

  Future fetchDailyConsumption(String uid, DateTime consumptionId) async{
    try{
      var data = await userCollection.document(uid).get();
      Map map = data.data;
      List consumptions = [for(var cons in map["daily_consumptions"]) new Daily_Consumption.fromMap(cons)];
      Daily_Consumption consumption = consumptions.firstWhere((dcons) => dcons.getDate() == consumptionId);
      return consumption;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future fetchMeal(String uid, DateTime consumptionId, String mealId) async{
    Daily_Consumption consumption = await this.fetchDailyConsumption(uid, consumptionId);
    return consumption.getMeal(mealId);
  }

  // Deletion for each object
  Future deleteUser(uid)async{
    try{
      return await userCollection.document(uid).delete();
    }catch(e){
      print(e.toString());
      return null;
    }
  } 

  Future deleteMealPlan(String id) async{
    try{
      return await mealPlanCollection.document(id).delete();
    }catch(e){
      print(e.toString());
      return null;
    }

    try{
      
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future deleteDailyConsumption(String uid, DateTime consumptionId) async{
    try{
      Daily_Consumption consumption = await this.fetchDailyConsumption(uid, consumptionId);
      return await userCollection.document(uid).updateData({
        "daily_consumptions":FieldValue.arrayRemove([consumption.mapify()])
        });
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future deleteMeal(String uid, DateTime consumptionId, String mealId)async{
    try{
      Daily_Consumption consumption = await this.fetchDailyConsumption(uid, consumptionId);
      await userCollection.document(uid).updateData({
        "daily_consumptions":FieldValue.arrayRemove([consumption.mapify()])
        });
      Meal meal = consumption.getMeal(mealId);
      consumption.removeMeal(meal);
      return await userCollection.document(uid).updateData({
        "daily_consumptions":FieldValue.arrayUnion([consumption.mapify()])
        });
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Update the objects in the database
  Future updateUser(User_Profile user) async{
    try{
      return await userCollection.document(user.getUid()).updateData(user.mapify());
    }catch(e){
      print(e.toStringa());
      return null;
    }
  }

  Future updateMealPlan(MealPlan mealPlan) async{
    try{
      return await mealPlanCollection.document(mealPlan.getId()).updateData(mealPlan.mapify());
    }catch(e){
      print(e.toStringa());
      return null;
    }
  }

  Future updateDailyConsumption(String uid, Daily_Consumption daily_consumption) async{
    try{
      Daily_Consumption old_dailyConsumption = await this.fetchDailyConsumption(uid, daily_consumption.getDate());
      await userCollection.document(uid).updateData({
          "daily_consumptions":FieldValue.arrayRemove([old_dailyConsumption.mapify()])
        });
      return await userCollection.document(uid).updateData({"daily_consumptions": FieldValue.arrayUnion([daily_consumption.mapify()])});
    }catch(e){
      print(e.toStringa());
      return null;
    }
  }

  Future updateMeal(String uid, DateTime consumptionId, Meal meal) async{
    try{
      Daily_Consumption consumption = await this.fetchDailyConsumption(uid, consumptionId);
      await userCollection.document(uid).updateData({
        "daily_consumptions":FieldValue.arrayRemove([consumption.mapify()])
        });
      Meal old_meal = consumption.getMeal(meal.getId());
      consumption.removeMeal(old_meal);
      consumption.addMeal(meal);
      return await userCollection.document(uid).updateData({
        "daily_consumptions":FieldValue.arrayUnion([consumption.mapify()])
        });
    }catch(e){
      print(e.toStringa());
      return null;
    }
  }
  
}