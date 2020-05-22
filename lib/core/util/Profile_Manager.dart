import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';
import 'package:Vainfitness/firebase_services/auth.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class ProfileManager{
  /// The currently authenticated user
  static User_Profile authenticatedUser;

  // Authentication object through firebase
  static AuthService _auth =  AuthService();
  static DatabaseManager db = DatabaseManager();

  
  // GETTERS
  static User_Profile getUser() {
    if (authenticatedUser == null) { return null;}
    return authenticatedUser;
  }

  /// check if an authenticated user is available
  static bool isUserAvailable() =>  authenticatedUser != null;

  /// Check if the authenticated user is a client
  static bool isClient() {
    if(isUserAvailable()){
       return  authenticatedUser is Client;   
    }
    return false;
  }

  /// Check if the authenticated user is a client
  static bool isFitnessCoach(){
    if(isUserAvailable()){
       return   authenticatedUser is Fitness_Coach;   
    }
    return false;
  }
   

  // SETTERS
  static void setUser(User_Profile user) =>  authenticatedUser = user;

  // MODIFIERS AND LOGIC
  
  /// Create a new client add the client to the database and creat an authentication
  static Future createFitnessCoachProfile(String firstname, String lastname, String username, String email,
      int month, int day, int year, int age, double height, double weight, String password) async{
    try{
      print("--> Creating Coach Profile");
       if( authenticatedUser != null){
          if( authenticatedUser is Fitness_Coach){
            dynamic regUser = await _auth.registerUser(email, password);
            String uid = regUser.uid.toString();
            Fitness_Coach newCoach = new Fitness_Coach(uid, firstname, lastname, username, email, month, day, year, age, height, weight);
            await db.addNewUser(newCoach);
          }else{print("access denied!");}
      }else{print("No user available");}
    }catch(e){
      print(e.toString());
    }
  }
  
  /// creates a new coach along with its authentication and adding to the database
  static Future createClientProfile(String firstname, String lastname, String username, String email,
      int month, int day, int year, int age, double height, double weight, double expectedWeight, int numDays,
      String password) async{
    try{
      print("--> Creating Client Profile");
      if( authenticatedUser != null){
        if( authenticatedUser is Fitness_Coach){
          dynamic regUser = await _auth.registerUser(email, password);
          String uid = regUser.uid.toString();
          Client newClient = new Client(uid, firstname, lastname, username, email, month, day, year, age, height, weight, expectedWeight, numDays);
          await db.addNewUser(newClient);
          return true;
        }else{print("access denied!");}
      }else{print("No user available");}
    }catch(e){
      print(e.toString());
    }
    return false;
  }

  static Future deleteUserprofile(String email, String password) async{
    try{
      print("--> Deleting the user profile");
      if( authenticatedUser != null){
        dynamic authUser = await _auth.signInUser(email, password);
        String uid = authUser.uid.toString();
        if( authenticatedUser.getUid() != uid){
          await db.deleteUser(uid);
          await _auth.deleteUserAccount(email, password);
        }else{print("cant delete logged in user");}
      }else{print("No user available");}
    }catch(e){
      print(e.toString());
    }
  }

  static Future deleteCurrentUser(String email, String password) async{
    try{
       print("--> Deleting the current profile");
      if( authenticatedUser != null){
        dynamic authUser = await _auth.signInUser(email, password);
        String uid = authUser.uid.toString();
        if( authenticatedUser.getUid() == uid){
          await db.deleteUser( authenticatedUser.getUid());
          await _auth.deleteUserAccount(email, password);
           authenticatedUser =  null;
        }
      }else{print("No user available");}
    } catch(e){
      print(e.toString());
    }
  }

  static Future updateCurrentUser() async{
    try{
      if( authenticatedUser != null){
        await db.updateUser( authenticatedUser);
        return true;
      }else{print("No user available");}
    }catch(e){
      print(e.toString());
    }
    return false;
  }
}