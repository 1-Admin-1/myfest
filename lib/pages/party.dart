//Librerias
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//Routes
import '../bloc/cart_bloc.dart';
import '../models/dbModel.dart';
import 'package:MyFest/widgets/party_detail_widget.dart';
import 'package:MyFest/widgets/party_listing_widget.dart';
//Pagina principal de PageParty
class PageParty extends StatefulWidget {
  const PageParty({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
//Estructura base 
class _MyHomePageState extends State<PageParty> {

  Widget build(BuildContext context) {
    //Crea bloques en forma de cubo que sera par amostrar la lista de fiestas
      return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EventsListingWidget(),//Manda a llamar clase para mostrar las listas
      ),
    );
  }
}
