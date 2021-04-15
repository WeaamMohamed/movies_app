import 'package:flutter/material.dart';
import 'package:movie_app/view/control_view.dart';
import 'package:movie_app/view/home_view.dart';

//TODO:
//search by movie name /// done
//show rate of movie ///done
//cast and crew of each movie //done
//watch trailer ///done
///show by categories
///add to favorites
///add english language only
///Flutter MovieApp - Tutorial #6
///check internet connection
//add series  //done
///account .. Auth
///saving favorites using sqlLite
///Refactor detail view

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: ThemeData.dark(),
      home: ControlView(),
    );
  }
}
