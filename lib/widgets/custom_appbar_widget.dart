import 'package:basmicorona/services/auth.dart';
import 'package:basmicorona/views/signin.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  //
  AuthService authService = new AuthService();
  final String iconText;
  CustomAppBarWidget({@required this.iconText});

  signOut(context) async {
    await authService.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => SignIn()),
        (Route router) => false);
  }

  back(context) {
    Navigator.of(context).pop();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            iconText == "exit" ? signOut(context) : back(context);
          },
          child: IconButton(
            icon: Icon(
              iconText == "exit" ? Icons.exit_to_app : Icons.arrow_back_ios,
              // FlutterIcons.menu,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ),
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
            image: DecorationImage(
              image: AssetImage("assets/images/profile.png"),
            ),
          ),
        )
      ],
    );
  }
}
