import 'dart:ui';

import 'package:MyFest/models/dbModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

//Clase ListEventsPage
//(Aun no esta implementado)
//Mostrar lista de asistentes
class UserEventDetailsPage extends StatefulWidget {
  EventDate events;
  UserEventDetailsPage({Key? key, required this.events}) : super(key: key);
  @override
  _UserEventDetailsPage createState() => _UserEventDetailsPage();
}

class _UserEventDetailsPage extends State<UserEventDetailsPage> {
// final docList = FirebaseFirestore.instance.collection('events').doc().snapshots();
//Consulta para lista de asistentes
  Stream<List<EventDate>> readList() => FirebaseFirestore.instance
      .collection('usersBusiness')
      .doc(widget.events.id)
      .collection('agenda')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => EventDate.fromJson(doc.data())).toList());

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Datos Generales",
          style: TextStyle(
            color: Color(0xfff70506),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ubicación",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.events.location,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Nombre",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.events.nombre,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Título",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.events.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Número de Teléfono",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.events.numeroTelefono,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Descripción",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.events.descripcion,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Fecha",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.events.fecha.toString().substring(0, widget.events.fecha.toString().length - 12),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Dirección",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.events.direccion,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Correo Electrónico del Usuario",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.events.userEmail,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
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
                child: Text(
                  'Num. Telefono: ${attendance.numeroTelefono.toString()}',
                  style: const TextStyle(color: Colors.black),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  'Asistentes: ${attendance.cantidadPersonas.toString()}',
                  style: const TextStyle(color: Colors.black),
                ),
              )),
          
        ],
      ),
      // trailing: const Icon(FontAwesomeIcons.instagram,
      //     color: Colors.purple, size: 30.0),
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

makeBody(int snapshot, List list) => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: snapshot,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(list[index]);
      },
    );
