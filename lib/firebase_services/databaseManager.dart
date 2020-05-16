import "package:cloud_firestore/cloud_firestore.dart";
/// This class aims on being an interface between the database and the application processes 
/// It provides the CRUD functions and serialization for the application objects to the databse
class DatabaseManager{
  final CollectionReference userCollection = Firestore.instance.collection("users");
  final CollectionReference consumptionCollection = Firestore.instance.collection("consumptions");
  final CollectionReference mealPlanCollection = Firestore.instance.collection("mealplans");
  final CollectionReference mealCollection = Firestore.instance.collection("meal");

  // Collection creation for each object or table creation for reg database
  Future createNewUser(int uid) async{
    return await userCollection.document(uid.toString()).setData({
      "id":{
        "1":"sd",
        "2":"asa"
      },
    });
  }
  
}