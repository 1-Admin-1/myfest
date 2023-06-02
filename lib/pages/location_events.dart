//Librerias
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//Routes
import '../models/dbModel.dart';

class PageLocationProfile extends StatefulWidget {
  const PageLocationProfile({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PageLocationProfile> {
  //Variable para ver el usaurio que esta logeado
  final user = FirebaseAuth.instance.currentUser!;


  Future<UsersProviders?> readUsersOne() async {
    final docUser =
        FirebaseFirestore.instance.collection('usersBusiness').doc(user.email);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return UsersProviders.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UsersProviders?>(
      future: readUsersOne(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Hubo un problema! ${snapshot.error}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          );
        } else if (snapshot.hasData) {
          final users = snapshot.data!;
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    users.nombreNegocio,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    users.numeroTelefono,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    users.direccionResidencia,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    users.rfc,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}
