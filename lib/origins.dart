import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Origins extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Any food origins you want ?'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Origins()));
        },
        label: Text('Next'),
        icon: Icon(Icons.arrow_right),
        backgroundColor: Colors.green,
      ),
    );
  }
}