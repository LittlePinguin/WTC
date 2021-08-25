import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_to_cook/recipe.dart';


class Results extends StatefulWidget{
  String foodtype;
  bool noIngredientSelected;
  var selectedIngredient = [];
  Results({this.foodtype, this.selectedIngredient, this.noIngredientSelected});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {

  var sortedIngredient = [];
  bool noRes = false;

  Widget build(BuildContext context){
    sortedIngredient = widget.selectedIngredient;
    sortedIngredient.sort();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover
            )
        ),
        child: FutureBuilder(
          future: widget.noIngredientSelected ? FirebaseFirestore.instance.collection('Menu').where('Type', isEqualTo: widget.foodtype).get()
                  : FirebaseFirestore.instance.collection('Menu').where('Type', isEqualTo: widget.foodtype).where('Ingredients', arrayContainsAny: sortedIngredient).get(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              if (documents.length > 0){
                return ListView(
                  scrollDirection: Axis.vertical,
                  children:documents.
                    map((doc) => InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Recipe(recipeName: doc['Title']))),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          child: FittedBox(
                            child: Material(
                              color: Colors.white70,
                              elevation: 14,
                              borderRadius: BorderRadius.circular(24),
                              shadowColor: Color(0x802196F3),
                              child: Row(
                                children: [
                                  Container(
                                    width: 300,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(doc['Title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                          ),
                                          SizedBox(height: 20),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Icon(Icons.access_time_rounded),
                                                ),
                                                Container(
                                                    child: Text(doc['Time'])
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  Container(
                                    height: 125,
                                    width: 125,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image(
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topRight,
                                        image: NetworkImage(doc['Image']),
                                        //image: AssetImage('images/'+doc['Image']),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    )).toList(),
                );
              }
              else{
                return Center(
                    child: Text('Sorry, no results found :(', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                );
              }
            }
            else{
              return Center(
                child: Container(
                  child: Text('Sorry, no results found :( .'),
                ),
              );
            }
          }
        ),
      ),
    );
  }
}
