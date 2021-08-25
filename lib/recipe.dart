import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Recipe extends StatelessWidget {

  String recipeName;
  Recipe({this. recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF54ADA2),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Menu').where('Title', isEqualTo: recipeName).get(),
        builder: (context, snapshot){
          if(snapshot.hasData){
           final List<DocumentSnapshot> documents = snapshot.data.docs;
           return ListView(
             scrollDirection: Axis.vertical,
             children:documents.
             map((doc) => Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Container(
                   height: 350,
                   width: 400,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.only(
                         bottomRight: Radius.circular(75),
                         bottomLeft: Radius.circular(75)
                     ),
                     ),
                   child: Image(image: NetworkImage(doc['Image']), fit: BoxFit.cover)
                   //Image.asset('images/'+doc['Image'], fit: BoxFit.cover),
                 ),
                 Container(
                   padding: EdgeInsets.all(30),
                   child: Container(
                     padding: EdgeInsets.all(15),
                     width: 350,v 
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(14)),
                       color: Colors.white70
                     ),
                     child: Column(
                       children: [
                         Text('Ingredients :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                         Text(doc['Recipe'].toString().replaceAll("_", "\n"), style: TextStyle(fontSize: 15)),
                       ],
                     ),
                   ),
                 ),
                 Container(
                   padding: EdgeInsets.only(right: 30, left: 30, bottom: 30),
                   child: Container(
                     padding: EdgeInsets.all(15),
                     width: 350,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(14)),
                         color: Colors.white70
                     ),
                     child: Column(
                       children: [
                         Text('Preparation :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                         Text(doc['Preparation'].toString().replaceAll("_", "\n"), style: TextStyle(fontSize: 15))
                       ],
                     ),
                   ),
                 ),
               ],
             )).toList(),
           );
          }
          else{
            return Container(
              child: Text('No data found !'),
            );
          }
        },
      ),
    );
  }
}