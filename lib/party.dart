import 'package:MyFest/party_detail_widget.dart';
import 'package:MyFest/party_listing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cart_bloc.dart';
import 'models/dataEvents.dart';
import 'detail_party.dart';

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
              children : const <Widget>[
                
                SizedBox(width: 15.0,height: 10.0,),
                Icon(Icons.celebration_rounded, color: Colors.white),
                SizedBox(width: 15.0,height: 10.0,),
                
              ],
              
            ),
            ),
           
            
          ),
          title: Text(
            events.title,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
          trailing:
              const Icon(Icons.keyboard_arrow_right, color: Color(0xfff70506), size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                      builder: (context) => 
                      
                      DetailPage(events: events)
                    ));
          },
        );

    Card makeCard(Events events) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: makeListTile(events),
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

      return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductListingWidget(),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Color(0xff272727),
    //   body:
    //       StreamBuilder<List<Events>>(
    //         stream: readEvents(),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasError) {
    //             return Text('Hubo un problema! ${snapshot.error}');
    //           } else if (snapshot.hasData) {
    //             final events = snapshot.data!;
                
    //             return Container(
    //               child: makeBody(snapshot.data!.length, events.toList()),
    //             );
    //           } else {
    //             return Center(child: CircularProgressIndicator());
    //           }
    //         },
    //       ),
    
    // );
  }
}
