import 'package:flutter/material.dart';
import 'dart:async';
import 'UI_Login.dart';

class SplashScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vain Nutrition',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
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
        seconds: 2
      ), 
      () =>  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage()
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color:Colors.lightBlue[50]),
            child: Column(              
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Center(
                      child: 
                        Image.asset('images/Logo_Red_out.png', 
                          width: 180.0, 
                          height: 120.0
                        ),
                    ),
                  ),
                ),
                    
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                            color: Colors.blue
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