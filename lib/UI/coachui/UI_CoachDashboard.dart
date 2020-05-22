import 'package:Vainfitness/UI/UI_CoachViewClients.dart';
import 'package:Vainfitness/UI/forms/AddMeal.dart';
import 'package:Vainfitness/UI/forms/addMealPlan.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:Vainfitness/core/user/Fitness_Coach.dart';


class UI_CoachDashboard extends StatelessWidget {

	Fitness_Coach coach = ProfileManager.getUser();
	List<String> clientid;
	static int totalClients;

	Future initiateClientFetch() async{
		try{
			var list =  coach.getClientsId() ;
			this.clientid =list;
			int numClients = list.length;
			UI_CoachDashboard.totalClients = numClients;
			}catch(e){
			print(e.toString());
			return false;
		}
	}
	//int gettotoalClients() => UI_CoachDashboard.totalClients;


	List vainGridComp = [
		{
			'icon': const IconData(
				0xe80a,
				fontFamily: 'VainIcons',
			),
			'title': 'Total Clients: ${totalClients.toString()} ',
			'route': null
		},
		{
			'icon': const IconData(
				0xe80e,
				fontFamily: 'VainIcons',
			),
			'title': 'Add New Client',
			'route': AddMealPlan()
		},
		{
			'icon': const IconData(
				0xe809,
				fontFamily: 'VainIcons',
			),
			'title': 'View Clients',
			'route': ViewClientList()
		},

	];

	Widget buildBoxTile(BuildContext context, String title, IconData icon, Widget route) => InkWell(
		onTap: () {
			Navigator.push(
				context,
				MaterialPageRoute(builder: (BuildContext context) => route),
			);
		},

		child: Container(
			decoration: BoxDecoration(
				color:  Color(0xFFbbdefb),
				borderRadius:  BorderRadius.all(Radius.circular(10)),
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
						style:  TextStyle(color: Color(0xFF8D6E63), fontSize: 20),


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

											text: 'Hey Coach!',

											type: GFTypographyType.typo5,
											dividerWidth: 25,
											dividerColor: Color(0xFFCDDC39),
										),
									),

									const SizedBox(
										height: 10,
									),


									Container(
										margin: EdgeInsets.all(10) ,
										child: GridView.builder(

												shrinkWrap: true,
												physics:  ScrollPhysics(),
												itemCount: vainGridComp.length,
												gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
														crossAxisCount: 2,
														crossAxisSpacing: 10,
														mainAxisSpacing: 10),
												itemBuilder: (BuildContext context, int index) =>
														GestureDetector(
//																onTap: () {
//																	Navigator.push(
//																			context,
//																			MaterialPageRoute(
//																				builder: (BuildContext context) =>
//																						AddMeal(),));
//																},
																child: buildBoxTile(
                                    context,
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
