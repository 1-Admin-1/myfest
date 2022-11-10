import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PageParty extends StatefulWidget {
  const PageParty({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PageParty> {
  Stream<List<Events>> readEvents() => FirebaseFirestore.instance
      .collection('events')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Events.fromJson(doc.data())).toList());

  Future<Events?> readEventsOne() async {
    final docUser = FirebaseFirestore.instance
        .collection('events')
        .doc('EFOZtmwUM2U6xtjTCmOF');
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return Events.fromJson(snapshot.data()!);
    }
  }

  Widget buildEvents(Events events) => ListTile(
        leading: Text(events.fecha.toIso8601String()),
        title: Text(events.title),
        subtitle: Text(events.descripcion),
      );

  int _counterAccept = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      // FutureBuilder<Events?>(
      //   future: readEventsOne(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       final events = snapshot.data;
      //       return events == null
      //           ? Center(child: Text('No Hay Fiestas Disponibles'))
      //           : buildEvents(events);
      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
      StreamBuilder<List<Events>>(
        stream: readEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Hubo un problema! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final events = snapshot.data!;

            return ListView(

              children: events.map(buildEvents).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }
        },
      ),
      // body: ListView(
      //   children: [
      //     showCard(),
      //     showCard(),
      //     showCard(),
      //   ],
      // ),
    );
  }

  Card showCard() {
    var rand = Random();

    var cardImage = NetworkImage(
        'https://source.unsplash.com/random/800x600?house&${rand.nextInt(100)}');
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      shadowColor: Colors.red,
      margin: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1)),
      child: Column(
        children: [
          ListTile(
            title: const Text('HALLOWEEN'),
            subtitle: Text(
              'ONLY +18 PEOPLE',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: Icon(Icons.favorite_outline),
          ),
          Container(
            child: Text(
              'USE COSTUMES IS REQUIRED',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            height: 200.0,
            width: 500.0,
            child: Ink.image(
              image: cardImage,
              fit: BoxFit.cover,
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      if (_counterAccept == 0) {
                        _counterAccept++;
                      } else if (_counterAccept == 1) {
                        _counterAccept--;
                      }
                    });
                  },
                  child: _counterAccept == 0
                      ? const Text('ACCEPT INVITATION')
                      : const Text('CANCEL INVITATION')),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_counterAccept == 0) {
                      _counterAccept++;
                    } else if (_counterAccept == 1) {
                      _counterAccept--;
                    }
                  });
                },
                icon: _counterAccept == 0
                    ? const Icon(
                        Icons.check_circle_outline,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.check_circle_outline,
                        color: Colors.lightGreen,
                      ),
              ),
            ],
          ),
          //
        ],
      ),
    );
  }
}

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
Card buildCard() {
  var ran = Random();
  var heading = '\$${(ran.nextInt(20) + 15).toString()}00 per month';
  var subheading =
      '${(ran.nextInt(3) + 1).toString()} bed, ${(ran.nextInt(2) + 1).toString()} bath, ${(ran.nextInt(10) + 7).toString()}00 sqft';
  var cardImage = NetworkImage(
      'https://source.unsplash.com/random/800x600?house&${ran.nextInt(100)}');
  var supportingText =
      'Beautiful home to rent, recently refurbished with modern appliances...';
  return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(heading),
            subtitle: Text(subheading),
            trailing: const Icon(Icons.favorite_outline),
          ),
          SizedBox(
            height: 200.0,
            child: Ink.image(
              image: cardImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(supportingText),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('CONTACT AGENT'),
                onPressed: () {/* ... */},
              ),
              TextButton(
                child: const Text('LEARN MORE'),
                onPressed: () {/* ... */},
              )
            ],
          )
        ],
      ));
}

class Events {
  late String id;
  late final String title;
  late final String descripcion;
  late final DateTime fecha;
  late final String direccion;
  late final int numeroDireccion;
  Events({
    this.id = '',
    required this.title,
    required this.descripcion,
    required this.fecha,
    required this.direccion,
    required this.numeroDireccion,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'descripcion': descripcion,
        'fecha': fecha,
        'direccion': direccion,
        'numeroDireccion': numeroDireccion,
      };
  static Events fromJson(Map<String, dynamic> json) => Events(
        id: json['id'],
        title: json['title'],
        descripcion: json['descripcion'],
        fecha: (json['fecha'] as Timestamp).toDate(),
        direccion: json['direccion'],
        numeroDireccion: json['numeroDireccion'],
      );
}
