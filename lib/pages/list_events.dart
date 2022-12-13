import 'dart:ui';

import 'package:MyFest/models/dbModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Clase ListEventsPage
//(Aun no esta implementado)
//Mostrar lista de asistentes
class ListEventPage extends StatefulWidget {
  Events events;
  ListEventPage({Key? key, required this.events}) : super(key: key);
  @override
  _ListEventPage createState() => _ListEventPage();
}

class _ListEventPage extends State<ListEventPage> {
// final docList = FirebaseFirestore.instance.collection('events').doc().snapshots();
//Consulta para lista de asistentes
  Stream<List<Attendance>> readList() => FirebaseFirestore.instance
      .collection('events')
      .doc(widget.events.id)
      .collection('listAttendance')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Attendance.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Attendance>>(
        stream:
            readList(), //llama la funcion para iniciar con el snapshot al builder
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } //circulo de carga
          final list = snapshot.data!;
              return Column(
                children: [
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                    
                     Text("Lista de Asistencia",
                        style: TextStyle(color: Colors.white,fontSize: 25,),)
                      
                    ],
                  ),
                  makeBody(snapshot.data!.length, list)
                ],
              );
              }
         
        );
  }
}

ListTile makeListTile(Attendance attendance) => ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      
      title: Text(
        attendance.nombre,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                child: Text('Asistentes: ${attendance.cantidadPersonas.toString()}',
                  
                  style: const TextStyle(color: Colors.black),
                ),
              )),
        ],
      ),
      trailing: const Icon(FontAwesomeIcons.instagram, color: Colors.purple ,size: 30.0),
      
    );
//Funcion para crear estructura base de la lista y poder mandar llamar la lista de snapshot
//en forma de Clase Events(Modelo de base de datos)
Card makeCard(Attendance attendance) => Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: makeListTile(attendance)),
    );

///Funcion para crear el cuerpo de toda la lista y asi dar formato
///incluir cantidad de datos, Lista de events

makeBody(int snapshot, List list ) => ListView.builder(
  scrollDirection: Axis.vertical,
  shrinkWrap: true,
  itemCount: snapshot,
  itemBuilder: (BuildContext context, int index) {
    return makeCard(list[index]);
  },
);
