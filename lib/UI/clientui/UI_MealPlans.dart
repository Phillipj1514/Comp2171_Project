import 'package:Vainfitness/UI/MealPlanDetail.dart';
import 'package:Vainfitness/UI/vain_icons_icons.dart';
import 'package:Vainfitness/core/nutrition/Meal.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:Vainfitness/core/util/MealPlan_Manager.dart';


class UI_MealPlan extends StatefulWidget {

  UI_MealPlan({Key key}): super(key:key);

  @override
  _UI_MealPlanState createState() => _UI_MealPlanState();
}

class _UI_MealPlanState extends State<UI_MealPlan> {
  
  //Future<List<MealPlan>> mealsLst = Future<List<MealPlan>>.delayed(Duration(seconds:2),() => 'Fetching MealPlans',);
  static Future _mealsList;

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

  Future subscribeToMeal(String mealPlanId) async{
    try{
      if(ProfileManager.isClient()){
        await MealPlanManager.addUserMealPlanSubscription(DateTime.now(), mealPlanId);
        final snackBar = SnackBar(content: Text('Meal Plan added '));
        Scaffold.of(this.context).showSnackBar(snackBar);
      }
    }catch(e){
      print(e.toString());
    }
  }

  Future initiateMealPlanFetch() async{
    try{
      var list = await MealPlanManager.loadMealPlanList();
      setState(() {
        _update(list);
      });
      //return list;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  void _update(Future listMP) async{
      setState(() => _mealsList = listMP);
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
              text: 'Subscribe',
              onPressed: () {
                subscribeToMeal(mealPlan.getId());
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
        future: MealPlanManager.loadMealPlanList(),
        builder: (context, mealPlanSnap){
  
          if(mealPlanSnap.hasData){
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: MealPlan_List.mealPlanLst.length,
                      itemBuilder: (context, index) {
                        return mealPlanCard(MealPlan_List.getMealPlan(index));
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
    //List<MealPlan> insMp = MealPlan_List.mealPlanLst;
    return Scaffold(
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

























