import 'dart:developer';
import 'package:MyFest/pages/party_list_profile.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

import 'package:MyFest/pages/edit_profile_page.dart';
import 'package:MyFest/widgets/appbar_widget.dart';
import 'package:MyFest/widgets/button_widget.dart';
import 'package:MyFest/widgets/numbers_widget.dart';
import 'package:MyFest/widgets/profile_widget.dart';

import 'package:MyFest/models/dataEvents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../bloc/cart_bloc.dart';
import '../models/userProfile.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class PageUser extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<PageUser> {
  final user = FirebaseAuth.instance.currentUser!;
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
                  ProfileWidget(
                    imagePath: 'userProfile.imagePath',
                    onClicked: () {
                      // Navigator.push(
                      //       context, MaterialPageRoute(builder: (_) => EditProfilePage()));
                    },
                  ),
                  const SizedBox(height: 24),
                  buildName(users.nombre,users.edad,users.email,users.numeroTelefono),
                  const SizedBox(height: 24),
                  Center(child: buildEditButton(users)),
                  const SizedBox(height: 24),
                  NumbersWidget(),
                  const SizedBox(height: 48),
                  buildList(),
                  const SizedBox(height: 8.0,),
                  const PagePartyProfile(),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
  }

  Widget buildName(String name,int edad, String email, String tel) => Column(
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

  Widget buildEditButton(Users user) => ButtonWidget(
        text: 'Editar Información',
        onClicked: 
          
          () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfilePage(user: user),
              )),
        
      );

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
