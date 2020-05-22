import 'package:Vainfitness/core/user/User_Profile.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:Vainfitness/firebase_services/auth.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';

class Authenticator{
  static AuthService _auth =  AuthService();
  static DatabaseManager db = DatabaseManager();

  static Future authenticateUser(String email, String password) async{
    try{  
      dynamic authUser = await _auth.signInUser(email, password);
      print("--> in authenticator authenticaate");
      String uid = authUser.uid.toString();
      print(uid);
      User_Profile user = await db.fetchUser(uid);
      ProfileManager.setUser(user);
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  static Future isUserLoggedIn() async{
    try{
      print("--> Checking the current signed in user");
      dynamic user = await _auth.getUser();
      String currentUID = user.uid.toString();
      if(currentUID == ProfileManager.getUser().getUid()){
        return true;
      }else{return false;}
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  static Future logoutUser() async{
    try{
      await ProfileManager.updateCurrentUser();
      await _auth.signOut();
      ProfileManager.authenticatedUser = null;
      return true;
    }catch(e){
      print(e.toString());
    }
    return false;
  }
  

}