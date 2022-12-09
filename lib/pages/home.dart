// ignore_for_file: use_key_in_widget_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'party.dart';
import 'user.dart';
import 'map.dart';
import 'create_events.dart';
import '../widgets/home_widget.dart';


//backgroundImage: AssetImage('assets/images/pin1.png'),
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    PageHome(),
    PageMap(),
    const PageParty(),
    PageUser(),
  ];
  // ignore: unused_field
  int _counter = 0;

  // Add 1 to the `_counter`
  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Remove 1 to the `_counter`
  // ignore: unused_element
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/logoNombre.png',
                fit: BoxFit.cover,
                height: 35.0,
              ),
            ],
          )),
      backgroundColor: const Color(0xff080404),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xfff70506),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => PageCreate()));
        },
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xff080404),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Color(0xfff70506),
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Color(0xffeaeaea),
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.location_on_rounded,
                    color: Color(0xfff70506),
                    size: 35,
                  )
                : const Icon(
                    Icons.location_on,
                    color: Color(0xffeaeaea),
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.celebration_rounded,
                    color: Color(0xfff70506),
                    size: 35,
                  )
                : const Icon(
                    Icons.celebration_outlined,
                    color: Color(0xffeaeaea),
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: Color(0xfff70506),
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Color(0xffeaeaea),
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}

class PageHome extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

final List<String> titles = [
  "HOME",
  "LOCATION",
  "PARTY",
  "USER",
];

final List<Widget> images = [
  Hero(
    tag: "HOME",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/images/home1.png",
        fit: BoxFit.contain,
      ),
    ),
  ),
  Hero(
    tag: "LOCATION",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/images/location1.png",
        fit: BoxFit.contain,
      ),
    ),
  ),
  Hero(
    tag: "PARTY",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/images/party1.png",
        fit: BoxFit.contain,
      ),
    ),
  ),
  Hero(
    tag: "USER",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/images/user1.png",
        fit: BoxFit.contain,
      ),
    ),
  ),
];

class _MyHomePageState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
          children: <Widget>[
            
            SizedBox(height: 20,),
            GridDashboard()
          ],
        ),
    );
  }
}
