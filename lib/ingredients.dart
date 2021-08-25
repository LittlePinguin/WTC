import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_to_cook/results.dart';

class Ingredients extends StatefulWidget{
  String foodType;
  Ingredients({this.foodType});
  @override
  _IngredientsState createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  bool folded = true;
  bool noIngredientSelected = false;
  TextEditingController searchController = TextEditingController();
  List<bool> isSelected = List.filled(45, false);
  List allResults = [];
  List resultsList = [];
  Future resultsLoaded;
  var ingredientList = [];
  var usedDoc;

  void initState(){
    super.initState();
    searchController.addListener(onSearchChanged);
  }

  void dispose(){
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void didChangeDependencies(){
    super.didChangeDependencies();
    resultsLoaded = getData();
  }

  onSearchChanged(){
    searchResultsList();
    print(searchController.text);
  }

  searchResultsList({int index = 0}){
    var showResults = [];
    if (searchController.text != ""){
      for (var elt in allResults){
        var name = elt['Name'].toString().toLowerCase();
        if (name.startsWith(searchController.text.toLowerCase())){
          showResults.add(elt);
        }
      }
    }
    else{
      showResults = List.from(allResults);
    }
    setState(() {
      resultsList = showResults;
    });
  }

  getData () async{
    var data = await FirebaseFirestore.instance.collection('Ingredients').orderBy('Name').get();
    setState(() {
      allResults = data.docs;
      // doc = resultsList[index];
    });
    searchResultsList();
    return true;
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Column(
                children: [
                  Text("What's in your fridge ?",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(color: Colors.black, offset: Offset(1,1), blurRadius: 1)])),
                  Text("\n If you don't have any preferences, \n just click on  'Next' , you'll have all the recipes.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          shadows: [Shadow(color: Colors.black, offset: Offset(1,1), blurRadius: 1)]))
                ],
              ),
              SizedBox(height: 50),
              Container(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: folded ? 56 : 200,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                    boxShadow: kElevationToShadow[6]
                  ),
                    child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 16),
                          child: !folded ? TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none
                            ),
                          ) : null,
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        //Fixing th splash
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(folded ? 32 : 0),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(folded ? 32 : 0),
                              bottomRight: Radius.circular(32)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                folded ? Icons.search : Icons.close,
                                color: Colors.blue[900],
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                folded = !folded;
                                searchController.clear();
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10
                      ),
                    scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: List.generate(resultsList.length, (index){
                        return Card(
                                    elevation: 10,
                                    child: InkWell(
                                      child: GridTile(
                                        footer: Container(
                                          color: Colors.black12,
                                          child: ListTile(
                                            leading: Text(resultsList[index]['Name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white, shadows: [Shadow(color: Colors.black, offset: Offset(1,1), blurRadius: 1)])),
                                          ),
                                        ),
                                        child: isSelected.elementAt(index) ?
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('images/'+resultsList[index]['Image'])
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(4)),
                                          ),
                                          child: Stack(
                                            children: [
                                            ClipRRect(
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Icon(Icons.check_circle_outline, size: 60, color: Colors.green),
                                                ),
                                              ),
                                            )
                                            ],
                                          ),
                                        ) :
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage('images/'+resultsList[index]['Image'])
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(4)),
                                          )
                                        )
                                      ),
                                      onTap: (){
                                        if(ingredientList.length>=10){
                                          if(isSelected.elementAt(index) == true){
                                            isSelected[index] = false;
                                            ingredientList.remove(resultsList[index]['Name']);
                                          }
                                          else {
                                            print('NUMBER INGREDIENTS MAX');
                                          }
                                        }
                                        else{
                                          if (isSelected.elementAt(index) == false){
                                            isSelected[index] = true;
                                            ingredientList.add(resultsList[index]['Name']);
                                          }
                                          else{
                                            isSelected[index] = false;
                                            ingredientList.remove(resultsList[index]['Name']);
                                          }
                                        }
                                        setState(() {
                                        });
                                      }
                                    ),
                      );})
                  ),
                // child: FutureBuilder(
                //   // future: FirebaseFirestore.instance.collection('Ingredients').orderBy('Name').get(),
                //   future: getData(),
                //   builder: (context, snapshot){
                //     if(snapshot.hasData){
                //       //final List<DocumentSnapshot> documents = snapshot.data.docs;
                //       return GridView(
                //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //           maxCrossAxisExtent: 150,
                //           crossAxisSpacing: 10,
                //           mainAxisSpacing: 10
                //         ),
                //         scrollDirection:Axis.vertical,
                //         children: List.generate(allResults.length, (index) {
                //           doc = allResults[index];
                //           // if (searchController.text != ""){
                //           //
                //           // }
                //           // else{
                //           //
                //           // }
                //           return Card(
                //             elevation: 10,
                //             child: InkWell(
                //               child: GridTile(
                //                 footer: Container(
                //                   color: Colors.black12,
                //                   child: ListTile(
                //                     leading: Text(doc['Name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white, shadows: [Shadow(color: Colors.black, offset: Offset(1,1), blurRadius: 1)])),
                //                   ),
                //                 ),
                //                 child: isSelected.elementAt(index) ?
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     image: DecorationImage(
                //                       fit: BoxFit.cover,
                //                       image: AssetImage('images/'+doc['Image'])
                //                     ),
                //                     borderRadius: BorderRadius.all(Radius.circular(10)),
                //                   ),
                //                   child: Stack(
                //                     children: [
                //                     ClipRRect(
                //                       child: BackdropFilter(
                //                         filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                //                         child: Container(
                //                           alignment: Alignment.center,
                //                           child: Icon(Icons.check_circle_outline, size: 60, color: Colors.green),
                //                         ),
                //                       ),
                //                     )
                //                     ],
                //                   ),
                //                 ) :
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     image: DecorationImage(
                //                     fit: BoxFit.cover,
                //                     image: AssetImage('images/'+doc['Image'])
                //                     //image: NetworkImage('https://github.com/LittlePinguin/WTC_images/blob/main/IngredientsImages/'+doc['Image'])
                //                   ),
                //                   borderRadius: BorderRadius.all(Radius.circular(10)),
                //                   )
                //                 )
                //               ),
                //               onTap: (){
                //                 if (isSelected.elementAt(index) == false){
                //                   isSelected[index] = true;
                //                   print(isSelected);
                //                   ingredientList.add(doc['Name']);
                //                   print(ingredientList);
                //                 }
                //                 else{
                //                   isSelected[index] = false;
                //                   print(isSelected);
                //                   ingredientList.remove(doc['Name']);
                //                   print(ingredientList);
                //                 }
                //                 setState(() {
                //                 });
                //               }
                //             ),
                //           );}
                //         )
                //       );
                //     }
                //     else{
                //       return Text('NO DATA FOUND !');
                //     }
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 30, right: 10),
        height: 50,
        width: 120,
        child: FittedBox(
          fit: BoxFit.cover,
          child: FloatingActionButton.extended(
              onPressed: (){
                if (ingredientList.isEmpty == true){
                  noIngredientSelected = true;
                }
                else{
                  noIngredientSelected = false;
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) => Results(foodtype: widget.foodType, selectedIngredient: ingredientList, noIngredientSelected: noIngredientSelected)));
              },
              label: Text('Next'),
              icon: Icon(Icons.arrow_right),
              backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}

// child: Container(
//   decoration: isSelected.elementAt(index) ?
//     BoxDecoration(
//       image: DecorationImage(
//           fit: BoxFit.cover,
//           image: AssetImage('images/apple.jpg')
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(4)),
//     ) :
//     BoxDecoration(
//       image: DecorationImage(
//           fit: BoxFit.cover,
//           image: AssetImage('images/'+doc['Image'])
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(4)),
//     ),
//     // decoration: isSelected.elementAt(index) ? BoxDecoration(color: Colors.green) : BoxDecoration(color: Colors.red),
//     // child: Image.asset('images/'+doc['Image'], fit: BoxFit.fill)
// ),