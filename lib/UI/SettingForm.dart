
// import 'package:dynamic_theme/dynamic_theme.dart';

import 'package:flutter/material.dart';

// void main() => runApp(SettingForm());

class SettingForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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



























































