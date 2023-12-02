import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../movie/movie_change_notifier.dart';
import '../movie/movie_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const String routeName = '/';

  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0;
  final List _children = [
    ChangeNotifierProvider<MovieChangeNotifier>(
      create: (_) => MovieChangeNotifier(),
      child: MovieList(),
    ),
    Container(),
    Container(),
    Container(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: Container(
        height: 80, // Adjust the height as needed
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Color(0xff2f273a),
                primaryColor: Color(0xff2f273a),
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow))),
            child: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.40),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              backgroundColor: Colors.purple,
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      color: _currentIndex==0?Colors.white:Colors.white.withOpacity(0.40),
                      "assets/images/dashboard_tab.svg",
                    ),
                    label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      color: _currentIndex==1?Colors.white:Colors.white.withOpacity(0.40),
                      "assets/images/watch_tab.svg",
                    ),
                    label: "Watch"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      color: _currentIndex==2?Colors.white:Colors.white.withOpacity(0.40),
                      "assets/images/media_lib_tab.svg",
                    ),
                    label: "Media"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      color: _currentIndex==3?Colors.white:Colors.white.withOpacity(0.40),
                      "assets/images/more_tab.svg",
                    ),
                    label: "More"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
