import 'package:Vainfitness/UI/UI_Login.dart';
import 'package:Vainfitness/UI/forms/Settings.dart';
import 'package:Vainfitness/core/util/Authenticator.dart';
import 'package:Vainfitness/core/util/Profile_Manager.dart';
import 'package:getflutter/components/drawer/gf_drawer.dart';
import 'package:getflutter/components/drawer/gf_drawer_header.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class Coach_Profile_Drawer extends StatefulWidget {
	@override
	_Coach_Profile_DrawerState createState() => _Coach_Profile_DrawerState();
}

class _Coach_Profile_DrawerState extends State<Coach_Profile_Drawer> {
	@override
	Widget build(
			BuildContext context
			) => GFDrawer(
		color: Colors.white,
		child: ListView(
			padding: EdgeInsets.zero,
			children: <Widget>[
				Container(
					decoration: BoxDecoration(
							gradient: LinearGradient(
									begin: Alignment.topCenter,
									end: Alignment.bottomCenter,
									colors: const [Color(0xFFD685FF), Color(0xFF7466CC)])),
					height: 250,
					child: GFDrawerHeader(
						closeButton: InkWell(
							onTap: () {
								Navigator.pop(context);
							},
							child: Icon(
								Icons.arrow_back,
								color: Colors.amber,
							),
						),
						decoration: BoxDecoration(
							gradient: LinearGradient(
								begin: Alignment.topCenter,
								end: Alignment.bottomCenter,
								colors: const [Color(0xFFD685FF), Color(0xFF7466CC)],
							),
						),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.start,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: <Widget>[
								GFAvatar(
									radius: 40,
									backgroundImage: AssetImage(
										'assets/images/coach.png',
									),
								),
								SizedBox(
									height: 5,
								),
								Text(
									ProfileManager.isUserAvailable()? ProfileManager.getUser().getUsername():"Username",
									style: TextStyle(
											fontSize: 20,
											fontWeight: FontWeight.w500,
											color: Colors.white),
								),
								SizedBox(
									height: 5,
								),
								Text(
									ProfileManager.isUserAvailable()? ProfileManager.getUser().getEmail():'email',
									style: TextStyle(color: Colors.white),
								),
							],
						),
					),
				),
				ListTile(
						title: Text('Settings'),
						onTap: (){
							Navigator.push(
								context,
								MaterialPageRoute(
									builder: (BuildContext context) =>
											Settings(),
								),
							);
						}
				),
				ListTile(
						title: Text('Logout'),
						onTap: (){
							Authenticator.logoutUser();
							Navigator.push(
								context,
								MaterialPageRoute(
									builder: (BuildContext context) =>
											LoginPage(),
								),
							);
						}
				),
			],
		),
	);

}
