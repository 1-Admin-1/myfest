import 'dart:ui';

import 'package:MyFest/models/dbModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//Clase ListEventsPage
//(Aun no esta implementado)
//Mostrar lista de asistentes
class ListEventPage extends StatefulWidget {
  Events events;
  ListEventPage({Key? key, required this.events}) : super(key: key);
  @override
  _ListEventPage createState() => _ListEventPage();

}
class _ListEventPage extends State<ListEventPage>{
// final docList = FirebaseFirestore.instance.collection('events').doc().snapshots();
//Consulta para lista de asistentes
  Stream<List<Attendance>> readList() => FirebaseFirestore.instance
      .collection('events')
      .doc(widget.events.id).collection('listAttendance')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Attendance.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Attendance>>(
        stream: readList(),//llama la funcion para iniciar con el snapshot al builder
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();//circulo de carga
          final list = snapshot.data!;
          return ListView.builder(//Regresa un builder para mostrar en un listview
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      Text(list.toList().toString()),
                      
                    ],
                  ),
                );
              });
        });
  }
}
