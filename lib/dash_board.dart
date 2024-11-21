import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_ui/search_tab.dart';
import 'package:netflix_ui/showmodel.dart';
import 'package:netflix_ui/utils/color.dart';
import 'home_tab.dart';


class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  List<Show> shows = [];
  List<Show> filteredShows = [];

  @override
  void initState() {
    super.initState();

  }

  List<Widget>tabs=[
    HomeTab(),
    SearchTab(),
    Center(child: Text("Other page",style: TextStyle(color: Colors.white),),)
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _onItemTapped(0);
                },
                child: Image.asset(
                  'assets/home_icon.png',
                  height: 30,
                  width: 30,
                  color: _selectedIndex ==0 ? Colors.white : Colors.white70,
                ),
              ),
              InkWell(
                onTap: () {
                  _onItemTapped(1);
                },
                child: Image.asset(
                  'assets/search_icon.png',
                  height: 30,
                  width: 30,
                  color: _selectedIndex == 1 ? Colors.white : Colors.white70,
                ),
              ),
              InkWell(
                onTap: () {
                  _onItemTapped(2);
                },
                child: Image.asset(
                  'assets/details_icon.png',
                  height: 30,
                  width: 30,
                  color: _selectedIndex == 2 ? Colors.white : Colors.white70,
                ),
              ),
            ],
          ),
        ),
        color: AppColors.black,
      ),
    );
  }


}
