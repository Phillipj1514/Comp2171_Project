import "package:firebase_auth/firebase_auth.dart";

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Register withe email and password for user
  Future registerUser(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  /// Sign in user with eamil and password
  Future signInUser(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  
  /// Get the current user
  Future getUser() async{
    return _auth.currentUser();
  }

  /// Get the current active user state
  Stream<FirebaseUser> get user{
    return _auth.onAuthStateChanged;
  }

  /// Sign In an anonymous user
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      //print(user.toString());
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  /// Sign user out 
  Future signOut() async{
    try{
      await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
void main(List<String> args) async{
  AuthService tas = AuthService();
  await tas.signInAnon();
}