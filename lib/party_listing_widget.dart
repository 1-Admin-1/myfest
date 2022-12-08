import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MyFest/app_theme.dart';
import 'package:MyFest/widgets/party_list.dart';
import 'package:flutter/material.dart';
import 'models/dataEvents.dart';

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

  Future<Events?> readEventsOne() async {
    final docUser = FirebaseFirestore.instance
        .collection('events')
        .doc('EFOZtmwUM2U6xtjTCmOF');
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return Events.fromJson(snapshot.data()!);
    }
  }
  

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
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                      child: Icon(
                        Icons.search_rounded,
                        color: Color(0xFF95A1AC),
                        size: 24,
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                    //     child: TextFormField(
                    //       controller: textController,
                    //       obscureText: false,
                    //       onChanged: (_) => EasyDebounce.debounce(
                    //         'tFMemberController',
                    //         Duration(milliseconds: 0),
                    //         () {
                    //           isSearchStarted =
                    //               textController!.text.isNotEmpty && textController!.text.trim().length > 0;
                    //           print('isSearchStarted $isSearchStarted');
                    //           if (isSearchStarted) {
                    //             print('${textController!.text.trim()}');
                    //             searchedProducts = readEvents
                    //                 .where((item) =>
                    //                     item.name.toLowerCase().contains(textController!.text.trim().toLowerCase()))
                    //                 .toList();
                    //           }
                    //           setState(() {});
                    //         },
                    //       ),
                    //       decoration: InputDecoration(
                    //         labelText: 'Buscar Evento...',
                    //         enabledBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: Color(0x00000000),
                    //             width: 1,
                    //           ),
                    //           borderRadius: const BorderRadius.only(
                    //             topLeft: Radius.circular(4.0),
                    //             topRight: Radius.circular(4.0),
                    //           ),
                    //         ),
                    //         focusedBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: Color(0x00000000),
                    //             width: 1,
                    //           ),
                    //           borderRadius: const BorderRadius.only(
                    //             topLeft: Radius.circular(4.0),
                    //             topRight: Radius.circular(4.0),
                    //           ),
                    //         ),
                    //       ),
                    //       style: AppTheme.of(context).bodyText1.override(
                    //             fontFamily: 'Poppins',
                    //             color: Color(0xFF95A1AC),
                    //           ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       BlocBuilder<CartBloc, CartState>(builder: (_, cartState) {
          //         bool isGridView = cartState.isGridView;
          //         return IconButton(
          //             onPressed: () {
          //               BlocProvider.of<CartBloc>(context).add(ChangeGallaryView(!isGridView));
          //             },
          //             icon: !isGridView ? Icon(Icons.grid_on) : Icon(Icons.list));
          //       }),
          //     ],
          //   ),
          // ),
          Expanded(
            child: PartyList(
             
            ),
          ),
        ],
      ),
    );
  }
}
