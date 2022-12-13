//Librerias
import 'package:MyFest/pages/list_events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//Routes
import '../bloc/cart_bloc.dart';
import '../models/dbModel.dart';
import 'package:MyFest/pages/edit_events.dart';
import 'package:MyFest/widgets/party_detail_widget.dart';
import 'package:MyFest/widgets/party_listing_widget.dart';

class PagePartyProfile extends StatefulWidget {
  const PagePartyProfile({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PagePartyProfile> {
  
  //Variable para ver el usaurio que esta logeado
  final user = FirebaseAuth.instance.currentUser!;

  ///Funcion para mandar llamadar una lista de datos de manera asincrona desde firebase
  ///leer los eventos que hay en la base de datos
  Stream<List<Events>> readEvents() => FirebaseFirestore.instance
      .collection('events')
      .where('user_email', isEqualTo: user.email)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Events.fromJson(doc.data())).toList());


  ///Funcion para mandar llamadar una lista de datos de manera asincrona desde firebase
  ///leer los eventos que hay en la base de datos
  ///solo hace la lecutra una vez de coleccion y documento especifico
  Future<Events?> readEventsOne() async {
    final docUser = FirebaseFirestore.instance
        .collection('events')
        .doc('EFOZtmwUM2U6xtjTCmOF');
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return Events.fromJson(snapshot.data()!);
    }
  }

  //Funcion eliminar evento de un doc especifico
  void deleteEvent(idDoc) {
    //Elimina en la coleccion el doc donde esta el evento especifico
    FirebaseFirestore.instance.collection('events').doc(idDoc).delete();
  }

  //funcion que redirigue para editar
  void pageEdit(Events events) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PageEdit(
            events: events,
          ),
        ));
  }

  //Muestra dialogo de confirmacion
  showAlertDialog({required Events events}) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
        child: const Text("Cancel"), onPressed: () => Navigator.pop(context));
    Widget continueButton = TextButton(
      child: const Text("Eliminar"),
      onPressed: () => {
        deleteEvent(events.id),
        Navigator.pop(context)
      }, //Funcion para eliminar
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Eliminar Evento"),
      content: const Text("¿Realmente quieres eliminar el evento?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ///Funcion para crear una lista con diseño dinamico
    ///Necesario mandar una clase Events (modelo de la base de datos), y cantidad de datos
    ListTile makeListTile(Events events) => ListTile(
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ListEventPage(
                  events: events,
                ),
              ));
          }),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          leading: Card(
            color: const Color(0xfff70506),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    width: 15.0,
                    height: 10.0,
                  ),
                  Icon(Icons.celebration_rounded, color: Colors.white),
                  SizedBox(
                    width: 15.0,
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            events.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Text(
                    events.direccion,
                    style: const TextStyle(color: Colors.black),
                  )),
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Color(0xfff70506), size: 30.0),
        );
//Funcion para crear estructura base de la lista y poder mandar llamar la lista de snapshot
    //en forma de Clase Events(Modelo de base de datos)
    Card makeCard(Events events) => Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Slidable(
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  //Actiones para deslizar y opciones de eliminar y editar
                  children: [
                    SlidableAction(
                      onPressed: (context) =>
                          pageEdit(events), //Redirigue a editar
                      // update(appointment),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Editar',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => showAlertDialog(
                          events: events), //Muestra confirmacion de eliminacion
                      // deleteAppointment(appointment),
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Eliminar',
                    ),
                  ],
                ),
                child: makeListTile(events)),
          ),
        );

    ///Funcion para crear el cuerpo de toda la lista y asi dar formato
    ///incluir cantidad de datos, Lista de events

    makeBody(int snapshot, List events) => Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot,
            itemBuilder: (BuildContext context, int index) {
              return makeCard(events[index]);
            },
          ),
        );

    ///Crear estructura en forma de lista de los snapshot que es de manera asincrona
    return StreamBuilder<List<Events>>(
      stream: readEvents(), // mandar a llamar la funcion para extraer datos
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //si hubo error al extraer los datos
          return Text('Hubo un problema! ${snapshot.error}');
        } else if (snapshot.hasData) {
          ///si hay datos
          final events = snapshot.data!;
          return Container(
            //manda llamar funcion para crear el body del pagina
            child: makeBody(snapshot.data!.length, events.toList()),
          );
        } else {
          //Texto de manda para decir al usuario que no hay fiestas creadas
          return const Padding(
            padding: EdgeInsets.only(left: 50.0),
            child: Text(
              "No tienes nunguna fiesta creada",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          );
        }
      },
    );
  }
}

