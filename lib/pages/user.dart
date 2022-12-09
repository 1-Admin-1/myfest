//Librerias
import 'dart:developer';
import 'package:MyFest/pages/party_list_profile.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

//Routes
import 'package:MyFest/pages/edit_profile_page.dart';
import 'package:MyFest/widgets/appbar_widget.dart';
import 'package:MyFest/widgets/button_widget.dart';
import 'package:MyFest/widgets/numbers_widget.dart';
import 'package:MyFest/widgets/profile_widget.dart';
import 'package:MyFest/models/dbModel.dart';
import '../bloc/cart_bloc.dart';


//Clase User
//Muestra informacion personal y eventos creados
class PageUser extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PageUser> {
  //Variable para obtener el usuario logeado y mostrar sus datos
  final user = FirebaseAuth.instance.currentUser!;
  //Funcion para leer los datos del usuario
  Future<Users?> readUsersOne() async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(user.email);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return Users.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users?>(
      future: readUsersOne(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Hubo un problema! ${snapshot.error}');
        } else if (snapshot.hasData) {
          final users = snapshot.data!;
          return Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                //Clase que da el diseno de la imagen(Aun no esta implementado)
                ProfileWidget(
                  imagePath: 'userProfile.imagePath',
                  onClicked: () {},
                ),
                const SizedBox(height: 24),
                //funcion para mostrar los datos del usuario
                buildName(users.nombre, users.edad, users.email,
                    users.numeroTelefono),
                const SizedBox(height: 24),
                //Boton de editar que manda el Modelo Users y asi pueda editarlos
                Center(child: buildEditButton(users)),
                const SizedBox(height: 24),
                //Clase que mostrara estadisticas(Aun no implementado)
                NumbersWidget(),
                const SizedBox(height: 48),
                //Funcion para mostrar titulo de las listas
                buildList(),
                const SizedBox(
                  height: 8.0,
                ),
                //Clase que muestra todas las listas creadas por el usuario
                const PagePartyProfile(),
              ],
            ),
          );
        } else {
          //Circulo de carga
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  //Funcion para mostrar nombre
  Widget buildName(String name, int edad, String email, String tel) => Column(
        children: [
          Text(
            '${name}, ${edad}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            tel,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
  //Funcion para editar informacion y redirigir a otra pagina
  Widget buildEditButton(Users user) => ButtonWidget(
        text: 'Editar Información',
        onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditProfilePage(
              user: user), //Clase EditProfilePage manda datos para modificar
        )),
      );
  //Funcion que disena titulo de las listas
  Widget buildList() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Fiestas Actuales',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
          ],
        ),
      );
}
