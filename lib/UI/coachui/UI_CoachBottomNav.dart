
import 'package:Vainfitness/UI/vain_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:Vainfitness/UI/coachui/UI_CoachDashboard.dart' as first;
import 'package:Vainfitness/UI/coachui/UI_CoachMealPlans.dart' as second;
import 'package:Vainfitness/UI/coachui/Coach_Profile_Drawer.dart';

void main() {
	runApp(
			MaterialApp(
					home:  CoachTabs(),
					routes: <String, WidgetBuilder> {}
			)
	);
}

class CoachTabs extends StatefulWidget {
	@override

	MyTabState createState() =>  MyTabState();
}


class MyTabState extends State<CoachTabs> with SingleTickerProviderStateMixin {

	TabController controller;
	@override
	void initState() {
		super.initState();
		controller =  TabController(vsync: this, length: 2);
	}

	@override
	void dispose() {
		controller.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		var profiledrawer = Coach_Profile_Drawer();
		return Scaffold(
				drawer: profiledrawer,
				appBar:
				AppBar(
					centerTitle: true,

					title: SizedBox(
						height: kToolbarHeight,
						child: Image.asset("assets/images/Logo_Blue_out.png"),
					),
				),

				bottomNavigationBar:  Material(
						color: Colors.blue[700],
						child:  TabBar(
								controller: controller,
								tabs: <Tab>[
									Tab(icon:  Icon(Icons.dashboard), text: 'Dashboard'),
									Tab(icon:  Icon(Icons.fastfood), text: 'MealPlans'),
								]
						)
				),
				body:  TabBarView(
						controller: controller,
						children: <Widget>[
							first.UI_CoachDashboard(),
							second.UI_CoachMealPlan()
						]
				)
		);
	}
}


