import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'map.dart';
import 'party.dart';
import 'user.dart';
import 'create.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'models/champion.dart';
import 'detail_view.dart';

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
    const PageMap(),
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
                height: 45.0,
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
      body: Column(
        children: <Widget>[
          // Container(
          //   color: Color.fromARGB(255, 0, 0, 0),
          //   width: double.infinity,
          //   height: 70,
          //   // child: Padding(
          //   //   padding: const EdgeInsets.symmetric(vertical: 15.0),
          //   //   child: Center(
          //   //         child: Image.asset(
          //   //       "assets/images/logo1.png",
          //   //       fit: BoxFit.cover,
          //   //     )),
          //   // ),
          // ),
          Expanded(
            child: Container(
              color: const Color(0xff212328),
              padding: EdgeInsets.all(50),
              child: VerticalCardPager(
                textStyle: const TextStyle(color: Colors.transparent),
                titles: titles,
                images: images,
                onPageChanged: (page) {
                  // print(page);
                },
                onSelectedItem: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailView(
                              champion:
                                  championsMap[titles[index].toLowerCase()]!,
                            )),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
