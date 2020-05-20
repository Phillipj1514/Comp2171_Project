import 'package:Vainfitness/UI/UI_Bottom_Nav.dart';
import 'package:Vainfitness/core/util/Authenticator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'UI_Login.dart';
import 'package:getflutter/getflutter.dart';

class SplashScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vain Nutrition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: const Color(0xFF6c5656),
        canvasColor: const Color(0xFFfafafa),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  Screen({Key key}) : super(key: key);
  @override
  SplashingScreen createState() => new SplashingScreen();
}

class SplashingScreen extends State<Screen> {
  
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(
        seconds: 5
      ), 
      () => Navigator.push(context,MaterialPageRoute(
        builder: (context) => LoginPage()))
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color:Colors.lightBlue[600]),
            child: Column(              
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Center(
                      child: 
                        Image.asset('assets/images/Logo_Blue_out.png', 
                          width: 180.0, 
                          height: 180.0
                        ),
                    ),
                  ),
                ),
                    
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // FutureBuilder(
                      //   future: Authenticator.isUserLoggedIn(),
                      //   builder: (context, snapshot){
                      //     if(snapshot.hasData){
                      //       if(snapshot.data == true){
                      //         //push the user to the HomeScreen if previously logged in
                      //         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Tabs()));
                      //         // return Container(
                      //         //     child: Text(
                      //         //       'Login already',
                      //         //       textAlign: TextAlign.center),
                      //         //   );
                      //       }else{
                      //         //Push the user to the login screen if no loggin data found
                      //         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage()));
                      //         //  return Container(
                      //         //     child: Text(
                      //         //       'Login first please',
                      //         //       textAlign: TextAlign.center),
                      //         //   );
                      //       }
                      //     }else if (snapshot.hasError) {
                      //       return Container(
                      //         child: Text(
                      //           'Network Problem',
                      //           textAlign: TextAlign.center),
                      //       );
                      //     }
                      //     return CircularProgressIndicator();
                      //   }
                      // ),
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        'Smart Nutrition',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: 
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white
                          )
                      )
                    ],
                  ),
                ),  
              ]  
            )
          )
        ]
      )
    );   
  }
}