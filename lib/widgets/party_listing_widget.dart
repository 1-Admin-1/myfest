import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MyFest/app_theme.dart';
import 'package:MyFest/widgets/party_list.dart';
import 'package:flutter/material.dart';
import '../models/dbModel.dart';

class ProductListingWidget extends StatefulWidget {
  const ProductListingWidget({Key? key}) : super(key: key);

  @override
  _ProductListingWidgetState createState() => _ProductListingWidgetState();
}

class _ProductListingWidgetState extends State<ProductListingWidget> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSearchStarted = false;
  
  List<Product> searchedProducts = [];
  Stream<List<Events>> readEvents() => FirebaseFirestore.instance
      .collection('events')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Events.fromJson(doc.data())).toList());


  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.of(context).primaryBackground,
                  width: 2,
                ),
              ),
            ),
          ),
          Expanded(
            child: PartyList(),
          ),
        ],
      ),
    );
  }
}
