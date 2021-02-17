import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import './vacation_bean.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedFontSize: 0,
          selectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.navigation, color: Colors.black), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark, color: Colors.black), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle, color: Colors.black),
                label: '')
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 40,
            ),
            child: Text(
              "Sonraki Durağını Keşfet",
              style: TextStyle(
                  letterSpacing: 1.3,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  height: 1.5),
            ),
          ),
          Expanded(child: PageViewWidget())
        ],
      ),
    );
  }
}

class PageViewWidget extends StatefulWidget {
  PageViewWidget({Key key}) : super(key: key);

  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  
  List<VacationBean> _list = [
    VacationBean(
    name: "Kız Kulesi",
    url:"../../assets/images/galata.jpg"),
    VacationBean(
    name: "Kız Kulesi",
    url:"../../assets/images/boat.jpg")
  ];

  PageController pageController;

  double viewportFraction = 0.8;
  double pageOffset = 0.0;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController.page;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: pageController,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          double scale = max(viewportFraction,
              (1 - (pageOffset - index).abs()) + viewportFraction);
          double angle = (pageOffset - index).abs();
          if (angle > 0.5) {
            angle = 1 - angle;
          }

          return Container(
            padding: EdgeInsets.only(
                right: 10, left: 20, top: 100 - scale * 25, bottom: 100),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: Material(
                elevation: 4,
                child: Stack(children: <Widget>[
                  Image.asset(
                    _list[index].url,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      bottom: 70,
                      left: 20,
                      child: AnimatedOpacity(
                        opacity: angle == 0 ? 1.0 : 0.0,
                        duration: Duration(
                          milliseconds : 200,
                        ),
                        child: Text(
                          _list[index].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ]),
              ),
            ),
          );
        });
  }
}
