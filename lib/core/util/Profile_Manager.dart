import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:Vainfitness/core/user/User_Profile.dart';
import 'package:Vainfitness/firebase_services/auth.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class ProfileManager{
  /// The currently authenticated user
  User_Profile authenticatedUser;

  // Authentication object through firebase
  AuthService _auth =  AuthService();
  DatabaseManager db = DatabaseManager();
  
  // CONSTRUCTOR
  ProfileManager(this.authenticatedUser);
  
  // GETTERS
  User_Profile getUser() {
    if (this.authenticatedUser == null) { return null;}
    return this.authenticatedUser;
  }

  /// check if an authenticated user is available
  bool isUserAvailable() => this.authenticatedUser != null;

  /// Check if the authenticated user is a client
  bool isClient() {
    if(isUserAvailable()){
       return this.authenticatedUser is Client;   
    }
    return false;
  }

  /// Check if the authenticated user is a client
  bool isFitnessCoach(){
    if(isUserAvailable()){
       return  this.authenticatedUser is Fitness_Coach;   
    }
    return false;
  }
   

  // SETTERS
  void setUser(User_Profile user) => this.authenticatedUser = user;

  // MODIFIERS AND LOGIC
  
  /// Create a new client add the client to the database and creat an authentication
  Future createFitnessCoachProfile(String firstname, String lastname, String username, String email,
      int month, int day, int year, int age, double height, double weight, String password) async{
    try{
      print("--> Creating Coach Profile");
       if(this.authenticatedUser != null){
          if(this.authenticatedUser is Fitness_Coach){
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
  Future createClientProfile(String firstname, String lastname, String username, String email,
      int month, int day, int year, int age, double height, double weight, double expectedWeight, int numDays,
      String password) async{
    try{
      print("--> Creating Client Profile");
      if(this.authenticatedUser != null){
        if(this.authenticatedUser is Fitness_Coach){
          dynamic regUser = await _auth.registerUser(email, password);
          String uid = regUser.uid.toString();
          Client newClient = new Client(uid, firstname, lastname, username, email, month, day, year, age, height, weight, expectedWeight, numDays);
          await db.addNewUser(newClient);
        }else{print("access denied!");}
      }else{print("No user available");}
    }catch(e){
      print(e.toString());
    }
  }

  Future deleteUserprofile(String email, String password) async{
    try{
      print("--> Deleting the user profile");
      if(this.authenticatedUser != null){
        dynamic authUser = await _auth.signInUser(email, password);
        String uid = authUser.uid.toString();
        if(this.authenticatedUser.getUid() != uid){
          await db.deleteUser(uid);
          await _auth.deleteUserAccount(email, password);
        }else{print("cant delete logged in user");}
      }else{print("No user available");}
    }catch(e){
      print(e.toString());
    }
  }

  Future deleteCurrentUser(String email, String password) async{
    try{
       print("--> Deleting the current profile");
      if(this.authenticatedUser != null){
        dynamic authUser = await _auth.signInUser(email, password);
        String uid = authUser.uid.toString();
        if(this.authenticatedUser.getUid() == uid){
          await db.deleteUser(this.authenticatedUser.getUid());
          await _auth.deleteUserAccount(email, password);
          this.authenticatedUser =  null;
        }
      }else{print("No user available");}
    } catch(e){
      print(e.toString());
    }
  }

  Future updateCurrentUser() async{
    try{
      if(this.authenticatedUser != null){
        await db.updateUser(this.authenticatedUser);
      }else{print("No user available");}
    }catch(e){
      print(e.toString());
    }
  }
}