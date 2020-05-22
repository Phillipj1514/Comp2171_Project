import 'package:Vainfitness/UI/forms/AddMeal.dart';
import 'package:Vainfitness/UI/forms/addMealPlan.dart';
import 'package:Vainfitness/UI/forms/checkCaloricValue.dart';
import 'package:Vainfitness/UI/forms/createUserProfile.dart';
import 'package:Vainfitness/core/util/Authenticator.dart';
import 'UI_Bottom_Nav.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  
  // final String title;
  
  // LoginPage({Key key, this.title}) : super(key: key);
  
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  
  void goTestZone(){
    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => AddMealPlan()));
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String error ="";

  Widget loginButtonText =  Text(
    "Login",
    style:  TextStyle(
      fontSize: 20.0, 
      color: Colors.white
    )
  );


  Future validateUser(String email, String password) async{
    try{
      //set the login button to circular progress var
      setState(() {
        loginButtonText = CircularProgressIndicator();
      });
      return await Authenticator.authenticateUser(email, password);
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future login() async{
    String email = emailController.text;
    String password  = passwordController.text;
    emailController.clear();
    passwordController.clear();
    if(! await Authenticator.isUserLoggedIn()){
      if(await validateUser(email, password)){
        setState(() {
          loginButtonText = Text(
            "Login",
            style:  TextStyle(
              fontSize: 20.0, 
              color: Colors.white
            )
          );
      
        });
        Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => Tabs()));
      }else{ 
        setState(() {
          error = "Try Again!";
          loginButtonText =  Text(
            "Login",
            style:  TextStyle(
              fontSize: 20.0, 
              color: Colors.white
            )
          );
        });
      }
    }else{
      print(await Authenticator.isUserLoggedIn());
      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => Tabs()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    
    return  Scaffold(      
      resizeToAvoidBottomPadding: false,
      appBar:  AppBar(
        backgroundColor: Colors.lightBlue[50],
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50]
        ),
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            Column( 
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  <Widget>[
             Image.asset('assets/images/Logo_Blue_out.png',width:180.0,height:120.0),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 10.0),
                  child:  Text(
                    "Smart Nutrition",
                    style:  TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 50.0),
              child:  Text(
                error,
                style:  TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.red

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child:  TextField(
                autofocus: true,
                decoration:  InputDecoration(focusColor: Colors.blue,labelText: 'Email or Username',hoverColor: Colors.blue),
                controller: emailController,
              ),
            ),
             SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child:  TextField(
                obscureText: true,
                decoration:  InputDecoration(labelText:"Password"),
                controller: passwordController,  
              ),                  
            ),
             Column(
              children: <Widget>[
                Row(                
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100.0 , right:100.0, top: 10.0),
                        child: GestureDetector( 
                          onTap: (){
                            login();
                          },
                    
                          child: Container(
                            alignment: Alignment.center,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(30.0)
                            ),
                            child: loginButtonText,
                          ),
                        ),
                      ),                          
                    ),
                  ]
                ),
                RaisedButton( 
                  onPressed: () {
                    goTestZone();
                  },
                  child: Text('Test Button', 
                  style: TextStyle(fontSize: 10))
                  ),
                 Row(                                    
                  children:<Widget>[ 
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 130.0, right: 20.0, top: 10.0
                      ),
                      child:  Container(
                        alignment: Alignment.center,
                        height: 50,
                        child:  Text("Forgot Password?",
                          style:  TextStyle(
                            fontSize: 12.0, color: Colors.blueAccent
                          )
                        )
                      ),
                    ) 
                  ] 
                ),
              ],
            ),
          ],
        ),
      
          ],
        ), 
      )
    );     
  }

}

void main() {
  runApp(LoginPage());
}
