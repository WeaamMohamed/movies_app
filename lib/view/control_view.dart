import 'package:flutter/material.dart';
import 'package:movie_app/view/home_view.dart';
import 'package:movie_app/view/search_result_view.dart';
import 'package:movie_app/view/tv_shows_view.dart';

import '../constants.dart';

class ControlView extends StatefulWidget {
  @override
  _ControlViewState createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //using indexed stack to keep state of pages so it does not reload
      body: IndexedStack(
        children: <Widget>[
          HomeView(),
          TvShowsView(),
          SearchResultView(),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: mainColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: 'All Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Tv Shows',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          //  _getCurrentScreen();
        },
      ),
    );
  }
}
