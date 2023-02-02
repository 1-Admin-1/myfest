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
        title: "Calendario",
        subtitle: "Marzo 2022",
        event: "50 Eventos",
        img: "assets/images/calendar.png");

    Items item2 = Items(
      title: "Terrazas",
      subtitle: "",
      event: "Lista de Terrazas",
      img: "assets/images/setting.png",
    );
    Items item3 = Items(
      title: "Puntos de Venta",
      subtitle: "Tiendas",
      event: "",
      img: "assets/images/map.png",
    );
    Items item4 = Items(
      title: "Promociones",
      subtitle: "Rose favirited your Post",
      event: "",
      img: "assets/images/setting.png",
    );
    Items item5 = Items(
      title: "Perfil",
      subtitle: "Datos de Usuario",
      event: "",
      img: "assets/images/usuario.png",
    );
    Items item6 = Items(
      title: "Configuración",
      subtitle: "",
      event: "",
      img: "assets/images/setting.png",
    );
    
      

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
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
      backgroundColor: Colors.black,
      
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
    
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: GridView.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                  childAspectRatio: .90,
                  children: myList.map((data){
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CupertinoButton(
                              onPressed: () {data.event;},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  image: DecorationImage(
                                    image:  AssetImage(data.img),
                                    fit: BoxFit.fill,)
                                ), 
                              ),
                            ),
                            Text(data.title),
                            Text(data.subtitle),
                            
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            ],
          )
        ],
      ),
    );
  }
}
class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({required this.title, required this.subtitle, required this.event, required this.img});
}