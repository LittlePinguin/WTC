import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:what_to_cook/ingredients.dart';

class FoodType extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 100),
                child: Text('What do you want to cook ?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(color: Colors.black, offset: Offset(1,1), blurRadius: 1)]))
            ),
            SizedBox(height: 170),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                            child: Text("Dish", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center),
                          ),
                          Icon(Icons.room_service, size: 30, color: Colors.black)
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Ingredients(foodType: "Plat")));
                    },
                  ),
                  SizedBox(height: 50),
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
                            child: Text("Dessert", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center),
                          ),
                          Icon(Icons.icecream, size: 30, color: Colors.black)
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Ingredients(foodType: "Dessert")));
                    },
                  ),
                  SizedBox(height: 50),
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
                            child: Text("Drink", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center),
                          ),
                          Icon(Icons.local_bar, size: 30, color: Colors.black)
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Ingredients(foodType: "Drink")));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}