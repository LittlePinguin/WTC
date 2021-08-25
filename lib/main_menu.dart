import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_to_cook/food_type.dart';
import 'package:connectivity/connectivity.dart';


class MainMenu extends StatefulWidget{
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  StreamSubscription sub;

  bool wifiOn = false;

  void initState(){
    super.initState();
    sub = Connectivity().onConnectivityChanged.listen((event) {
      setState((){
        wifiOn = (event != ConnectivityResult.none);
      });
    });
  }

  void dispose(){
    sub.cancel();
    super.dispose();
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                child: Image(
                  image: AssetImage('images/bgMenu.png'),
                )
              ),
            ),
            SizedBox(height: 150),
            wifiOn ?
            InkWell(
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF062247),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(30),
                              topLeft: Radius.circular(30)
                          )
                      ),
                      child: Text("Let's cook", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center),
                    ),
                    Icon(Icons.local_dining, size: 30, color: Colors.black)
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FoodType()));
              },
            )
            :
            Column(
              children: [
                Icon(Icons.wifi_off, size: 100),
                Text('No connection !', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      )
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-40);
    path.quadraticBezierTo(size.width/4, size.height, size.width/2, size.height);
    path.quadraticBezierTo(size.width-(size.width/4), size.height, size.width, size.height-40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
