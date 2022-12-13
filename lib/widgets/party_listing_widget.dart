//Librería
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Routes
import 'package:MyFest/app_theme.dart';
import 'package:MyFest/widgets/party_list.dart';
import '../models/dbModel.dart';

///Class ProductListingWidget
/// Inicializa la clase
/// Estructura base para mandar a llamar los eventos en forma de lista
class EventsListingWidget extends StatefulWidget {
  const EventsListingWidget({Key? key}) : super(key: key);

  @override
  _EventsListingWidgetState createState() => _EventsListingWidgetState();
}

class _EventsListingWidgetState extends State<EventsListingWidget> {
  TextEditingController? textController;//Controlador de text
  final scaffoldKey = GlobalKey<ScaffoldState>();//llave para mantener el estado
  bool isSearchStarted = false;//variable que sera utilizada para hacer una busqueda
  
  ///Variable de una busqueda de fiestas (Aun no implementada)
  List<Product> searchedEvent = [];

  ///Funcion para inicializar el estado de un objeto
  ///Called when this object is inserted into the tree.
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //Estructura del front
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
            child: PartyList(),//Clase PartyList
          ),
        ],
      ),
    );
  }
}
