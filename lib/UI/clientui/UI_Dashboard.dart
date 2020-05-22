import 'package:Vainfitness/UI/forms/AddMeal.dart';
import 'package:Vainfitness/UI/forms/checkCaloricValue.dart';
//import 'package:Vainfitness/UI/grid_dash.dart';
import 'package:Vainfitness/UI/vain_icons_icons.dart';
import 'package:Vainfitness/core/nutrition/Daily_Consumption.dart';
import 'package:Vainfitness/core/user/Client.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';

class UI_Dashboard extends StatelessWidget {

  String greeting(){
    DateTime date = DateTime.now();
    if(date.hour >= 6  && date.hour < 12){ return "Good morning";}
    else if(date.hour >= 12  && date.hour < 18){return "Good afternoon";}
    else if(date.hour >= 18  && date.hour < 21){return "Good evening";}
    return "Good night";
  }

  Widget clientDailyProgress(){
    int total = 0;
    int used  = 0;
    try{
      if(ProfileManager.isClient()){
        Client client =  ProfileManager.getUser();
        total = client.getDailyCalorie();

        Daily_Consumption daily_consumption = client.getDailyConsumptionByDate(DateTime.now());
        daily_consumption.getMeals().forEach((meal) { 
          used += meal.getTotalNutrients().getCalorie();
        });
      }
    }catch(e){
      print(e.toString());
    }
    print(used);
    print(total);
    
    return Container(
      //color: Colors.greenAccent ,
      //padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all (
              color: Colors.blueAccent
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      child: CircularProgress(double.parse(total.toString()), double.parse(used.toString()))
    );
  }

  List vainGridComp = [
    {
      'icon': const IconData(
        0xe805,
        fontFamily: 'VainIcons',
      ),
      'title': 'Add Breakfast',
      'route': AddMeal()
    },
    {
      'icon': const IconData(
        0xe803,
        fontFamily: 'VainIcons',
      ),
      'title': 'Add Lunch',
      'route': AddMeal()
    },
    {
      'icon': const IconData(
        0xe806,
        fontFamily: 'VainIcons',
      ),
      'title': 'Add Dinner',
      'route': AddMeal()
    },
    {
      'icon': const IconData(
        0xe804,
        fontFamily: 'VainIcons',
      ),
      'title': 'Add Snack',
      'route': AddMeal()
    },
  ];

  Widget buildBoxTile(String title, IconData icon, Widget route) => InkWell(


    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFbbdefb),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.white70,
              blurRadius: 6,
              spreadRadius: 0),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon,
            //color: Color(0xFFCDDC39),
            color: Color(0xFF8D6E63),

            // GFColors.SUCCESS,
            size: 50,
          ),
//            Icon((icon),),
          Text(
            title,
           // style: const TextStyle(color: GFColors.WHITE, fontSize: 20),
              style: const TextStyle(color: Color(0xFF8D6E63), fontSize: 20),


          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: GFTypography(

                text: greeting(),

                type: GFTypographyType.typo5,
                dividerWidth: 25,
                dividerColor: Color(0xFFCDDC39),
              ),
            ),
            //Text( 'Good Morning'),
            
            clientDailyProgress(),

            const SizedBox(
              height: 10,
            ),

             Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: GFTypography(

                      text: 'Check Your Meals, Stay on Track',

                      type: GFTypographyType.typo5,
                      dividerWidth: 25,
                      dividerColor: Color(0xFFCDDC39),
                    ),
                  ),



              GFCard(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround ,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child:
                          Icon(VainIcons.food_for_check_cal_val),
                        ),
                        Expanded(
                          flex: 2,
                          child:
                              GFButton(
                                onPressed: () {
                                  Navigator.push( context,
                                      MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      CheckCaloricValue(),
                                      )
                                  );
                                },
                                child: const Text(
                                    'Check Calorie',
                                    ),
                                    color: GFColors.PRIMARY,
                                    size: GFSize.LARGE,
                                    buttonBoxShadow: true,
                              ),
                        ),
                      ],
                    )
                  ]
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: GFTypography(

                text: 'Keep Track of your meal',

                type: GFTypographyType.typo5,
                dividerWidth: 25,
                dividerColor: Color(0xFFCDDC39),
              ),
            ),

            Container(
              margin: EdgeInsets.all(10) ,
              child: GridView.builder(

                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: vainGridComp.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (BuildContext context) =>
                                AddMeal(),));
                          },
                          child: buildBoxTile(
                              vainGridComp[index]['title'],
                              vainGridComp[index]['icon'],
                              vainGridComp[index]['route']))
              ),
            ),

          ]
        )
      )
    );
  }
}

/// Builds a Circular progress bar thats responsive to data sent in. 
/// It takes first the base calories, ie. the recommended calories for a user per day
/// It also takes the current change to the daily consumption list: Ie the current 
/// total consumed. 
class CircularProgress extends StatefulWidget {
  final double baseCalorie;
  final double changeCalorie;


  CircularProgress(this.baseCalorie, this.changeCalorie, {Key key}) : super(key: key);
  double getparamBase()=> this.baseCalorie;
  @override
  _CircularProgressState createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {
  double _calories = 2250;
  double _percent = 0.3;
  
  @override
  void initState() {
    super.initState();
  }

  double _caloriesRemaining(){
    var remaining;
    setState(() {
      _calories = widget.baseCalorie - widget.changeCalorie;
      remaining = _calories;
    });
    return remaining;
  }

  double _getPercent(double changingCal, double baseCal){
    var percent;
    setState(() {
      _percent = changingCal/baseCal;
      percent =  _percent;
    });
    return percent;
  }

  @override
  Widget build(BuildContext context) {
      return Container(

        padding: EdgeInsets.all(25.0),
        child:Column(
          children: [
            CircularPercentIndicator(
             progressColor: Colors.lime ,
              //progressColor: Colors.brown ,
              percent: _getPercent(widget.changeCalorie, widget.baseCalorie),
              animation: true,
              radius: 150.0,
              lineWidth: 10.0,
              circularStrokeCap: CircularStrokeCap.round,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: [
                  Text("${_caloriesRemaining()}"), 
                  Text("remaining"),
                ]
            ),)
          ],
        )
    );
  }
}
