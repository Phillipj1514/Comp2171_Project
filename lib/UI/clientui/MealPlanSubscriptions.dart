import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';
import 'package:Vainfitness/firebase_services/databaseManager.dart';
import 'package:flutter/material.dart';
import 'package:Vainfitness/UI/MealPlanDetail.dart';

import 'package:Vainfitness/UI/MealPlanDetail.dart';
import 'package:Vainfitness/UI/vain_icons_icons.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:Vainfitness/core/util/MealPlan_Manager.dart';


class MealPlanSubscriptions extends StatefulWidget {
  @override
  _MealPlanSubscriptionsState createState() => _MealPlanSubscriptionsState();
}

class _MealPlanSubscriptionsState extends State<MealPlanSubscriptions> {

  List<MealPlan> mealplans;

  //Future<List<MealPlan>> mealsLst = Future<List<MealPlan>>.delayed(Duration(seconds:2),() => 'Fetching MealPlans',);

  String mealPlanDetails(MealPlan mealPlan){
    String result = "This meal plan have the meals: \n";
    try{
      mealPlan.getMealList().forEach((Meal meal) { 
        String textmeal = "--> "+meal.getName()+"\n";
        result+=textmeal;
      });
    }catch(e){
      print(e.toString());
    }
    return result;
  }

  Future unSubscribeToMeal(String mealPlanId) async{
    try{
      if(ProfileManager.isClient()){
        await MealPlanManager.removeUserMealPlanSubscription(mealPlanId);
        setState(() {
          mealplans;
        });
      }
    }catch(e){
      print(e.toString());
    }
  }

 // int lst = (MealPlan_List.mealPlanLst).length;

  Widget mealPlanCard(MealPlan mealPlan){
    return Container(
      child: GFCard(
        boxFit: BoxFit.cover,
        image: Image.asset(
          'assets/images/meal_two.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        titlePosition: GFPosition.end,
        title: GFListTile(
          titleText: 
          //'Staring With A Boost!',
          mealPlan.getName() ,
          subtitleText: 'Total Caloric Value: '+mealPlan.getTotalNutrition().getCalorie().toString(),
          icon: Icon(VainIcons.technology) ,
        ),
        content: Text(
          'This meal plan will ensure you have a boost of energy that lasts all the days.\n ------------------------------------------------------------ \n'
          +mealPlanDetails(mealPlan),
          style: TextStyle(color: Colors.grey),
        ),
        buttonBar: GFButtonBar(
          padding: const EdgeInsets.only(bottom: 10),
          children: <Widget>[
            GFButton(
              text: 'Unsubscribe',
              color: Colors.red,
              onPressed: () {
                unSubscribeToMeal(mealPlan.getId());
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //       MealPlanDetails() ,
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    ); 
  }
  
  Widget listOFMealPlans(){
    return Container(
      child: FutureBuilder(
        future: MealPlanManager.getClientMealPlanSubscriptions(),
        builder: (context, mealPlanSnap){
          if(mealPlanSnap.hasData){
            mealplans = mealPlanSnap.data;  
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mealplans.length,
                    itemBuilder: (context, index) {
                      return mealPlanCard(mealplans[index]);
                      //return Text(MealPlan_List.getMealPlan(index).getName());
                    }
                  )
                ],
              ),
            );
          }else if( mealPlanSnap.hasError){
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child:Text("Nothing to Show",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );  
        },
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:  Text("MealPlan Subscriptions"), backgroundColor: Colors.amberAccent),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            listOFMealPlans(),
          ],
        )
      )
    );
  }
}
