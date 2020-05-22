import 'package:flutter/material.dart';
import 'package:Vainfitness/UI/forms/AddMeal.dart';
import 'package:Vainfitness/UI/forms/addMealPlan.dart';
import 'package:Vainfitness/UI/timelineCL.dart';

class UI_ConsumptionLst extends StatelessWidget {
  List vainGridComp = [
    {
      'icon': const IconData(
        0xe836,
        fontFamily: 'VainIcons',
      ),
      'title': 'Plan your meal',
      'route': AddMeal(),
    },
    {
      'icon': const IconData(
        0xe80c,
        fontFamily: 'VainIcons',
      ),
      'title': 'Edit Meal Plan',
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
                                            AddMealPlan(),));
                                },
                                child: buildBoxTile(
                                    vainGridComp[index]['title'],
                                    vainGridComp[index]['icon'],
                                    vainGridComp[index]['route']))
                    ),
                  ),
                 // TimelineCL(),
                ]
            )
        )
    );
  }
}