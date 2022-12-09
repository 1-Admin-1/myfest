import 'package:MyFest/widgets/party_detail_widget.dart';
import 'package:MyFest/widgets/party_listing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../models/dbModel.dart';


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
  }
}
