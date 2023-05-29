//Librerias
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Routes
import 'package:MyFest/Utils.dart';
import 'package:MyFest/utils/verify_email.dart';
import 'package:flutter/material.dart';
import 'utils/auth_page.dart';



// Main 
//Declarada en futuro por espera que inicie firabase en la app
FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 
  runApp(MyApp());//Inicia a correr el programa con la clase MyApp
}
//Llave de para la navegacion de la app y asi no se pierda el estado durante 
// su uso por las interfaces
final navigatorKey = GlobalKey<NavigatorState>();

//Clase MyApp
//Widget Principal
//Esta compuesto con estructura base de titulo y un home con una clase el cual redirigirá
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      title: 'MyFest',
      home:
      MainPage(),//Clase MainPage
    );
  }
}

//Clase MainPage
/*Estructura Base
Permite sabe el estado en que se encuentra el usuario, permitiendo
sabe si el usuario sigue logeado o no aunque haya cerrado la aplicacion.
Si el usuario no ha verificado su cuenta entonces pasa a un estado de espera
y no loguea
*/
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(), //Cambia un estado de sign in o sign out con ayuda de firebase
          builder: (context, snapshot) {
            //En espera a recibir el snapshot de datos de Firebase authentication
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('HUBO UN ERROR!'),
              );
            } else if (snapshot.hasData) {
              return VerifyEmailPage(); //Clase que verifica el email
            } else {
              return AuthPage();//Clase de autenticacion de usuario
            }
          },
        ),
      );
}