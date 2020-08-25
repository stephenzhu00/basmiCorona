import 'package:flutter/material.dart';

class RapidPage extends StatefulWidget {
  @override
  _RapidPageState createState() => _RapidPageState();
}

class _RapidPageState extends State<RapidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.red
              // AppColors.mainColor.withOpacity(.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Image.asset("assets/images/virus.png"),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .25,
              right: 25,
              child: Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Image.asset("assets/images/person.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
