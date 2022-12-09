///Librerias

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
///Routes
import '../app_theme.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/state/cart_state.dart';
import '../models/dbModel.dart';
import 'party_detail_widget.dart';

///Clase en donde mandamos a imprimir todas las listas con forma de GRID y List
//
class PartyList extends StatefulWidget {
  PartyList({Key? key}) : super(key: key);


  ///Creates the mutable state for this widget at a given location in the tree.
  @override
  _MyPartyList createState() => _MyPartyList();
}

class _MyPartyList extends State<PartyList> {
  final user = FirebaseAuth.instance.currentUser!;
  
  ///Funcion para mandar llamadar una lista de datos de manera asincrona desde firebase
  ///leer los eventos que hay en la base de datos
  Stream<List<Events>> readEvents() => FirebaseFirestore.instance
      .collection('events')//collecion eventos
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Events.fromJson(doc.data())).toList());///regresar en forma de lista dinamica

  ///Funcion para mandar llamadar una lista de datos de manera asincrona desde firebase
  ///leer los eventos que hay en la base de datos
  ///solo hace la lecutra una vez de coleccion y documento especifico
  Future<Events?> readEventsOne() async {
    final docUser = FirebaseFirestore.instance
        .collection('events')//coleccion
        .doc('jIANP4VCeH2kGWhMbtmK');//documento
    final snapshot = await docUser.get();//en espera a obtener datos
    if (snapshot.exists) {//si existe datos mandar al modelo de Events como json
      return Events.fromJson(snapshot.data()!);
    }
  }

  ///Funcion para crear una lista con diseño dinamico
  ///Necesario mandar una clase Events (modelo de la base de datos), y cantidad de datos
  OpenContainer makeListTile(Events events, itemNo) => OpenContainer<bool>(
        openBuilder: (BuildContext _, VoidCallback openContainer) {
          ///Si presiona retorna una clase PartyDetailWidget para ver detalles de eventos
          return PartyDetailWidget(
            events: events,
            
          );
        },
        closedShape: const RoundedRectangleBorder(),
        closedElevation: 0.0,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          ///Retorna en una estructura base de container para la vista del front
          return Container(
           //Decoracion de caja en lista
            decoration: BoxDecoration(
              color: Color(0xff453658),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x3600000F),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Image.asset(
                            'assets/images/logoNombre.png', //Mandar a llamar imagen default (siguiente version sera personalizable)
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                          child: Text(
                            events.title,//mandar a llamar titulo de la clase Events
                            style: AppTheme.of(context).bodyText4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                          child: Text(
                            events.fecha.toString().replaceAll("00:00:00.000", ""),
                            style: AppTheme.of(context).bodyText3,
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
      );


  //Funcion para crear estructura base de la lista y poder mandar llamar la lista de snapshot 
  //en forma de Clase Events(Modelo de base de datos) y necesario incluir el numero de datos
  Padding makeCard(Events events, int itemNo) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: makeListTile(events, itemNo),// manda a llamar funcion

      );
  ///Funcion para crear el cuerpo de toda la lista y asi dar formato
  ///incluir cantidad de datos, Lista de events y variable para poder 
  ///renderizar cada grid que se crea
  makeBody(int snapshot, List events, BoxConstraints constraints) => Container(
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: snapshot,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(events[index], index);//madar a llamar la funcion con events en forma del modelo y su cantidad de datos
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
            childAspectRatio: 1,
          ),
        ),
      );
  /// Estructura principal para mandar a llamar los datos de firabse en forma de snapshot en tiempo real 
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<CartBloc, CartState>(builder: (_, cartState) {
      bool isGridView = cartState.isGridView;
      if (isGridView) {
        return LayoutBuilder(builder: (context, constraints) {
          ///Crear estructura en forma de lista de los snapshot que es de manera asincrona
          return StreamBuilder<List<Events>>(
            stream: readEvents(),// mandar a llamar la funcion para extraer datos
            builder: (context, snapshot) {
              if (snapshot.hasError) {//si hubo error al extraer los datos 
                return Text('Hubo un problema! ${snapshot.error}');
              } else if (snapshot.hasData) {///si hay datos
                final events = snapshot.data!;
                return LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    //manda llamar funcion para crear el body del pagina
                    child: makeBody(
                        snapshot.data!.length, events.toList(), constraints),
                  );
                });
              } else {/// circulo de carga
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        });
      } else {// circulo de carga
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
