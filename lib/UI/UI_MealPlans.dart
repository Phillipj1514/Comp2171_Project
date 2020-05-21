import 'package:Vainfitness/UI/vain_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'Profile_Drawer.dart';

class UI_MealPlan extends StatefulWidget {
  @override
  _UI_MealPlanState createState() => _UI_MealPlanState();
}

class _UI_MealPlanState extends State<UI_MealPlan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class UI_MealPlans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          child: ListView(
            children: <Widget>[
              GFCard(
              boxFit: BoxFit.cover,
              image: Image.asset(
                'assets/images/meal_two.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              titlePosition: GFPosition.end,
              title: GFListTile(
                titleText: 'Staring With A Boost!',
                subtitleText: 'Daily Caloric Value: 2400',
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
                    onPressed: () {},
                    text: 'More Info',
                  ),
                ],
              ),
            ),
          ]
        )
    );
  }
}






























/* Scaffold(
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.amber[600],
              child: const Center(
                child: Text(
                  'Entry A'
                )
              ),
            ),
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(
                child: Text(
                  'MealPlans'
                )
              ),
            ),
            Container(
              height: 50,
              color: Colors.amber[100],
              child: const Center(
                child: Text(
                  'Entry C'
                )
              ),
            ),
          ],
        ),
      ),
    ); */