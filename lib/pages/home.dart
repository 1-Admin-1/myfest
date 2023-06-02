// ignore_for_file: use_key_in_widget_constructors
//Librerias
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//Routes
import 'party.dart';
import 'user.dart';
import 'map.dart';
import 'create_events.dart';
import '../widgets/home_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
  //Bottom appbar 
  //Muestra las paginas con las que se puede interactuar
  //Contador para mostrar todas las paginas segun el clic
  BottomAppBar buildMyNavBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
    child: Container(
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
    ),
    );
  }
}

class PageHome extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<PageHome> {
  Items item1 = Items(
        title: "MyFest",
        subtitle: "Mi Fiesta, Tu Fiesta",
        description: "¡No te pierdas el festival del año!",
        explanation: "Descubre los mejores artistas y eventos.",
        img: "assets/images/playstore.png",
      );

    Items item2 = Items(
      title: "¿Quiénes somos?",
      subtitle: "",
      description: "Somos un equipo apasionado dedicado a crear experiencias increíbles.",
      explanation: "Conoce nuestra historia y nuestro compromiso con la calidad.",
      img: "assets/images/festival.png",
    );

    Items item3 = Items(
      title: "¿Para quiénes?",
      subtitle: "",
      description: "Nuestros eventos están diseñados para todos los amantes de la diversión y la música.",
      explanation: "Descubre cómo creamos momentos memorables para personas de todas las edades.",
      img: "assets/images/usuario.png",
    );

    Items item4 = Items(
      title: "¿Cuándo podemos?",
      subtitle: "",
      description: "Nuestros eventos se llevan a cabo durante todo el año, con opciones para todos los gustos.",
      explanation: ".",
      img: "assets/images/calendar.png",
    );

    
    
      

 @override
Widget build(BuildContext context) {
  List<Items> myList = [item1, item2, item3, item4];
  return Scaffold(
    
    backgroundColor: Colors.black,
    body: Swiper(
      itemCount: myList.length,
      itemBuilder: (BuildContext context, int index) {
        Items currentItem = myList[index];

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Image.asset(
                    currentItem.img,
                    width: 200,
                    height: 200,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          currentItem.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          currentItem.subtitle,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Text(
                          currentItem.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          currentItem.explanation,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

}
class Items {
  String title;
  String subtitle;
  String description;
  String explanation;
  String img;

  Items({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.explanation,
    required this.img,
  });
}