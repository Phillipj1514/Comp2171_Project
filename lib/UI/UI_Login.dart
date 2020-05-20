import 'UI_Bottom_Nav.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
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
        child:  Column( 
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  <Widget>[
             Image.asset('images/Logo_Blue_out.png',width:180.0,height:120.0),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 70.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child:  TextField(
                autofocus: true,
                decoration:  InputDecoration(focusColor: Colors.blue,labelText: 'Email or Username',hoverColor: Colors.blue),
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
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => Tabs()
                              )
                            );
                          },
                    
                          child: Container(
                            alignment: Alignment.center,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(30.0)
                            ),
                            child:  Text(
                              "Login",
                              style:  TextStyle(
                                fontSize: 20.0, 
                                color: Colors.white
                              )
                            )
                          ),
                        ),
                      ),                          
                    ),
                  ]
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
      )
    );     
  }
}

void main() {
  runApp(LoginPage());
}
