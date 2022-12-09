import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_theme.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/state/cart_state.dart';
import '../models/dataEvents.dart';

import 'party_detail_widget.dart';

class PartyList extends StatefulWidget {
  PartyList({Key? key}) : super(key: key);

  @override
  _MyProductList createState() => _MyProductList();
}

class _MyProductList extends State<PartyList> {
  final user = FirebaseAuth.instance.currentUser!;
  
  Stream<List<Events>> readEvents() => FirebaseFirestore.instance
      .collection('events')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Events.fromJson(doc.data())).toList());

  Future<Events?> readEventsOne() async {
    final docUser = FirebaseFirestore.instance
        .collection('events')
        .doc('jIANP4VCeH2kGWhMbtmK');
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return Events.fromJson(snapshot.data()!);
    }
  }

  OpenContainer makeListTile(Events events, itemNo) => OpenContainer<bool>(
        openBuilder: (BuildContext _, VoidCallback openContainer) {
          return PartyDetailWidget(
            events: events,
            
          );
        },
        closedShape: const RoundedRectangleBorder(),
        closedElevation: 0.0,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          return Container(
            //width: MediaQuery.of(context).size.width * 0.45,
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
                            'assets/images/logoNombre.png',
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
                            events.title,
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

  Padding makeCard(Events events, int itemNo) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: makeListTile(events, itemNo),

        // Container(
        //   decoration: const BoxDecoration(color: Colors.white),
        //   child: makeListTile(events),
        // ),
      );

  makeBody(int snapshot, List events, BoxConstraints constraints) => Container(
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: snapshot,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(events[index], index);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
            childAspectRatio: 1,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<CartBloc, CartState>(builder: (_, cartState) {
      bool isGridView = cartState.isGridView;
      if (isGridView) {
        return LayoutBuilder(builder: (context, constraints) {
          
          return StreamBuilder<List<Events>>(
            stream: readEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Hubo un problema! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final events = snapshot.data!;
                return LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    child: makeBody(
                        snapshot.data!.length, events.toList(), constraints),
                  );
                });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        });
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
