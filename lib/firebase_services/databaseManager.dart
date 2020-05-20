import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:intl/intl.dart';
/// This class aims on being an interface between the database and the application processes 
/// It provides the CRUD functions and serialization for the application objects to the databse
class DatabaseManager{
  final CollectionReference userCollection = Firestore.instance.collection("users");
  final CollectionReference mealPlanCollection = Firestore.instance.collection("mealplans");
  final CollectionReference staticCountCollection = Firestore.instance.collection("static_counts");

  // document creation for each object or table creation for reg database
  Future addNewUser(User_Profile user) async{
    try{
      return await userCollection.document(user.getUid()).setData(user.mapify());
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  
  Future addNewMealPlan(MealPlan mealplan) async{
    try{
      return await mealPlanCollection.document(mealplan.getId()).setData(mealplan.mapify());
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future addNewDailyConsumption(Daily_Consumption daily_consumption, String uid) async{
    try{
      return await userCollection.document(uid).updateData({"daily_consumptions": FieldValue.arrayUnion([daily_consumption.mapify()])});
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  
  Future addNewMeal(Meal meal, String uid, DateTime consumptionID) async{
    try{
      var data = await userCollection.document(uid).get();
      Map dbdata = data.data;
      List consumps = [for(var cons in dbdata["daily_consumptions"]) new Daily_Consumption.fromMap(cons)];
      // try to fetch the specific daily consumption and remove it
      Daily_Consumption consump = consumps.firstWhere((dcons) => DateFormat('yyyy-MM-dd').format(dcons.getDate()) == DateFormat('yyyy-MM-dd').format(consumptionID));
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
      if(await this.fetchStatic() == null){
        await this.updateStatic();
      }
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
    if(await this.fetchStatic() == null){
      await this.updateStatic();
    }
    return mealplans;
  }

  Future fetchDailyConsumption(String uid, DateTime consumptionId) async{
    try{
      var data = await userCollection.document(uid).get();
      Map map = data.data;
      List consumptions = [for(var cons in map["daily_consumptions"]) new Daily_Consumption.fromMap(cons)];
      Daily_Consumption consumption = consumptions.firstWhere((dcons) => DateFormat('yyyy-MM-dd').format(dcons.getDate()) == DateFormat('yyyy-MM-dd').format(consumptionId));
       if(await this.fetchStatic() == null){
          await this.updateStatic();
        }
      return consumption;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future fetchMeal(String uid, DateTime consumptionId, String mealId) async{
    Daily_Consumption consumption = await this.fetchDailyConsumption(uid, consumptionId);
    if(await this.fetchStatic() == null){
      await this.updateStatic();
    }
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
      await this.updateStatic(); 
      return await userCollection.document(user.getUid()).updateData(user.mapify());
    }catch(e){
      print(e.toStringa());
      return null;
    }
  }

  Future updateMealPlan(MealPlan mealPlan) async{
    try{
      await this.updateStatic();
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
      await this.updateStatic(); 
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
      await this.updateStatic(); 
      return await userCollection.document(uid).updateData({
        "daily_consumptions":FieldValue.arrayUnion([consumption.mapify()])
        });
    }catch(e){
      print(e.toStringa());
      return null;
    }
  }

  Future updateStatic() async{
    try{
      print("--> updating static counting variables");
      Map<String, dynamic> statics = {
        "meal_count": Meal.getMealCount(),
        "mealPlan_count": MealPlan.mealPlanCnt
      };
      return await staticCountCollection.document("main").setData(statics);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future fetchStatic() async{
    try{
      print("--> getting static counting variables");
      var data = await  staticCountCollection.document("main").get();
      Map map = data.data;
      Meal.setCount(map["meal_count"]);
      MealPlan.mealPlanCnt = map["mealPlan_count"];
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  
  Future deleteStatic(uid)async{
    try{
      print("--> deleting static counting variables");
      return await staticCountCollection.document("main").delete();
    }catch(e){
      print(e.toString());
      return null;
    }
  }   
}