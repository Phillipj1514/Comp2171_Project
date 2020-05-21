import 'package:Vainfitness/UI/vain_icons_icons.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/components/progress_bar/gf_progress_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UI_Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView(
          children: <Widget>[
            Container( 
              height: MediaQuery.of(context).size.height -140,
              child: CircularProgress(2500.0, 1800.0))]),),);
            // LinearCarbsProgress(),
            // CircularProgress(2500.0, 1000.0),])),);
             
              // GFProgressBar(
              //   percentage: 0.5,
              //   width: 300, 
              //   radius: 250.0,
              //   circleStartAngle: 45.0,
                // child: const Padding(
                //   padding:EdgeInsets.only(right: 5) ,
                //   child: Text( 
                //     '50%', 
                //     textAlign: TextAlign.end,
                //     style: TextStyle(
                //       fontSize: 16, 
                //       color: Colors.black
                //     ),
                //   ),
                // ),
                // backgroundColor: Colors.black26,
                // progressBarColor: GFColors.WARNING,
             // ),
              /* Row(
                
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(children: [
                    Text('Protein'),
                    GFProgressBar(
                      percentage: 0.9,
                      backgroundColor: Colors.black26,
                      progressBarColor: GFColors.DANGER
                    ),
                    Text('${90}.%'),
                  ],),
                  Column(children: [
                    Text('Protein'),
                    GFProgressBar(
                      percentage: 0.9,
                      backgroundColor: Colors.black26,
                      progressBarColor: GFColors.DANGER
                    ),
                    Text('${90}.%'),
                  ],),
                  Column(children: [
                      Text('Protein'),
                      GFProgressBar(
                        percentage: 0.9,
                        backgroundColor: Colors.black26,
                        progressBarColor: GFColors.DANGER
                      ),
                      Text('${90}.%'),
                    ],
                  ),
                ],
              ), */
            //],
          //),),
         //);
        // Card(
        //   child: Row(
        //     children: [  
        //       Icon(VainIcons.food_for_check_cal_val),
        //       SafeArea(

        //         child: Row(
        //           children: [
        //             Text( 'Check Calorie'),
        //             SearchBar(onSearch: null, onItemFound: null),
        //           ]
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // GridView.count(
        //   crossAxisCount: 2,
        //   children: [
        //     Card(
        //       child: Center(
        //         child: Column(
        //           children: [
        //             Icon(VainIcons.breakfast),
        //             Text('Add a Breakfast item', softWrap: true ),
        //         ],
        //         )
        //       ),
        //     ),
        //     Card(
        //       child: Center(
        //         child: Column(
        //           children: [
        //             Icon(VainIcons.tray_black),
        //             Text('Add a Lunch item', softWrap: true ),
        //         ],
        //         )
        //       ),
        //     ),
        //     Card(
        //       child: Center(
        //         child: Column(
        //           children: [
        //             Icon(VainIcons.diner),
        //             Text('Add a Dinner item', softWrap: true ),
        //         ],
        //         )
        //       ),
        //     ),
        //     Card(
        //       child: Center(
        //         child: Column(
        //           children: [
        //             Icon(VainIcons.food_and_restaurant),
        //             Text('Add a Snack item', softWrap: true ),
        //         ],
        //         )
        //       ),
        //     )
        //   ],
        // ),
      //]
   // ),);
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
              progressColor: Colors.redAccent,
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



class LinearFatsProgress extends StatefulWidget {
  LinearFatsProgress({Key key}) : super(key: key);

  @override
  _LinearFatsProgressState createState() => _LinearFatsProgressState();
}

class _LinearFatsProgressState extends State {

 int _calories = 2250;
  @override
  
  void initState() {
    super.initState();
  }
  void _incrementCalories(int increaseAmt){
    setState(() {
      _calories+= increaseAmt;
    });
  }

  void _decrementCalories(int decAmount){
    setState(() {
      _calories -= decAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.all(25.0),
        child:Column(
          children: [
            LinearPercentIndicator(
              width: 100.0,
              lineHeight: 10.0,
              progressColor: Colors.orangeAccent,
              percent: 0.7,
              //center: Text("Circle"),
              animation: true,
            )
          ],
        )
    );
  }
}



class LinearCarbsProgress extends StatefulWidget {
  LinearCarbsProgress({Key key}) : super(key: key);

  @override
  _LinearCCarbsProgressState createState() => _LinearCCarbsProgressState();
}

class _LinearCCarbsProgressState extends State {

 int _calories = 2250;
  @override
  
  void initState() {
    super.initState();
  }
  void _incrementCalories(int increaseAmt){
    setState(() {
      _calories+= increaseAmt;
    });
  }

  void _decrementCalories(int decAmount){
    setState(() {
      _calories -= decAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.all(25.0),
        child:Column(
          children: [
            LinearPercentIndicator(
              width: 100.0,
              lineHeight: 10.0,
              progressColor: Colors.orangeAccent,
              percent: 0.7,
              //center: Text("Circle"),
              animation: true,
            )
          ],
        )
    );
  }
}



class LinearProteinProgress extends StatefulWidget {
  LinearProteinProgress({Key key}) : super(key: key);

  @override
  _LinearProteinProgressState createState() => _LinearProteinProgressState();
}

class _LinearProteinProgressState extends State {

 int _calories = 2250;
  @override
  
  void initState() {
    super.initState();
  }
  void _incrementCalories(int increaseAmt){
    setState(() {
      _calories+= increaseAmt;
    });
  }

  void _decrementCalories(int decAmount){
    setState(() {
      _calories -= decAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.all(25.0),
        child:Column(
          children: [
            LinearPercentIndicator(
              width: 100.0,
              lineHeight: 10.0,
              progressColor: Colors.orangeAccent,
              percent: 0.7,
              //center: Text("Circle"),
              animation: true,
            )
          ],
        )
    );
  }
}














































