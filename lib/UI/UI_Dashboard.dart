import 'package:flutter/material.dart';

class UI_Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(
          centerTitle: true,
        
          title: 
            SizedBox(
              height: kToolbarHeight,
              child: Image.asset("images/Logo_Red_out.png"),
            ),
          leading:
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ), 
        ),
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
                  'HomeScreen'
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
    );
  }
}



























































