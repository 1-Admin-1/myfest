import 'package:MyFest/pages/edit_events.dart';
import 'package:MyFest/widgets/party_detail_widget.dart';
import 'package:MyFest/widgets/party_listing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../bloc/cart_bloc.dart';
import '../models/dbModel.dart';

class PagePartyProfile extends StatefulWidget {
  const PagePartyProfile({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PagePartyProfile> {
  final user = FirebaseAuth.instance.currentUser!;
  Stream<List<Events>> readEvents() => FirebaseFirestore.instance
      .collection('events')
      .where('user_email', isEqualTo: user.email)
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

  void deleteEvent(idDoc) {
    //Elimina en la coleccion el doc donde esta el evento especifico
    FirebaseFirestore.instance.collection('events').doc(idDoc).delete();
  }

  void pageEdit(Events events) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PageEdit(
            events: events,
          ),
        ));
  }

  showAlertDialog(BuildContext context, {required Events events}) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () =>Navigator.of(context, rootNavigator: false).pop(),
    );
    Widget continueButton = TextButton(
      child: Text("Eliminar"),
      onPressed: () => {deleteEvent(events.id)},
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar Evento"),
      content: Text("¿Realmente quieres eliminar el evento?"),
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

  Widget build(BuildContext context) {
    ListTile makeListTile(Events events) => ListTile(
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
                  child: Container(
                    child: Text(
                      events.direccion,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Color(0xfff70506), size: 30.0),
        );

    Card makeCard(Events events) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Slidable(
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => pageEdit(events),
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
                      onPressed: (context) =>
                          showAlertDialog(context, events: events),
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

    return StreamBuilder<List<Events>>(
      stream: readEvents(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Hubo un problema! ${snapshot.error}');
        } else if (snapshot.hasData) {
          final events = snapshot.data!;
          return Container(
            child: makeBody(snapshot.data!.length, events.toList()),
          );
        } else {
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
