import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:Vainfitness/firebase_services/auth.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  
  MyHomePage({Key key, this.title}) : super(key: key);
  
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  AuthService _auth =  AuthService();
  DatabaseManager db = DatabaseManager();

  // Just a testing space for console code before ui
  void testArea() async{
    // await _auth.signInAnon();
    
    // dynamic regUser = await _auth.registerUser("test@text.com", "123456");
    // await _auth.signInUser("test@text.com", "123456");
    //await _auth.signOut();
    // Get the current User
  //   dynamic result = await _auth.getUser();
  //   print(result.uid.toString()); 
  //   String uid = result.uid.toString();
  //   // Database Testing
  //   Client tc = new Client(uid,"John","Paul","jp",3,12,1990,30,5,160,140,20);
  //   Fitness_Coach tfc = new Fitness_Coach(uid,"Simon", "Peter","sp",1,1,1982,26,5,150);
  //   MealPlan tmpln = new MealPlan.defaultConst();
  //   Daily_Consumption tdc = new Daily_Consumption();
  //   Meal tml = new Meal();
  //   Client data = await db.fetchUser(uid);
  //   //print(data);
  //  Daily_Consumption dummdc = data.getDailyConsumption(0);

    //db.addNewUser(tc);
    //db.addNewMealPlan(tmpln);
    //db.addNewDailyConsumption(tdc, uid);
    //db.addNewMeal(tml, uid, dummdc.getDate());
    // Client savedcli = await db.fetchUser(uid);
    // print(savedcli.getName());
    // List<MealPlan> mealpls = await db.fetchMealPlans();
    // print(mealpls[0].getName());
    // Daily_Consumption dc = await db.fetchDailyConsumption(uid, dummdc.getDate());
    // print(dc.getDate());
    // Meal ttm = await db.fetchMeal(uid, dummdc.getDate(), "meal_78");
    // print(ttm.getName());
    //db.deleteMealPlan("mealplan_0");
    //db.deleteDailyConsumption(uid, dummdc.getDate());
    // db.deleteMeal(uid, dummdc.getDate(), "meal_64");
    // data.setFirstname("new Name");
    // db.updateUser(data);
    // dummdc.date = DateTime.now();
    // db.updateDailyConsumption(uid, dummdc);
    // ttm.setName("new name");
    // db.updateMeal(uid, dummdc.getDate(), ttm);

  }

  void _incrementCounter() async{
    // Testing function for built in functionalities
    testArea();

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
  
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
