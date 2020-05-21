import 'package:Vainfitness/UI/MealPlanDetail.dart';
import 'package:Vainfitness/UI/vain_icons_icons.dart';
import 'package:Vainfitness/core/nutrition/MealPlan.dart';
import 'package:Vainfitness/core/nutrition/MealPlan_List.dart';
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
          subtitleText: 'Daily Caloric Value: 2500',
          icon: Icon(VainIcons.technology) ,
        ),
        content: Text(
          'This meal plan will ensure you have a boost of energy that lasts all day.',
          style: TextStyle(color: Colors.grey),
        ),
        buttonBar: GFButtonBar(
          padding: const EdgeInsets.only(bottom: 10),
          children: <Widget>[
            GFButton(
              text: 'More Info',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      MealPlanDetails() ,
                  ),
                );
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



























//  Scaffold(
//       body: Container(
//         child: ListView(
//           padding: const EdgeInsets.all(8),
//           children: <Widget>[
//             Container(
//               height: 50,
//               color: Colors.amber[600],
//               child: const Center(
//                 child: Text(
//                   'Entry A'
//                 )
//               ),
//             ),
//             Container(
//               height: 50,
//               color: Colors.amber[500],
//               child: const Center(
//                 child: Text(
//                   'MealPlans'
//                 )
//               ),
//             ),
//             Container(
//               height: 50,
//               color: Colors.amber[100],
//               child: const Center(
//                 child: Text(
//                   'Entry C'
//                 )
//               ),
//             ),
//           ],
//         ),
//       ),
//    