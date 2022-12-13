import 'dart:async';
//routes
import 'package:MyFest/Utils.dart';
import 'package:MyFest/pages/home.dart';
//Libreria
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//Clase para verificar el correo
class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPage createState() => _VerifyEmailPage();
}

class _VerifyEmailPage extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
//Inicializa un estado en donde un boton no se habilita despues de 3 segundos para evitar
// que el usuario pueda presionarlo
  @override
  void initState() {
    super.initState();
    //El usuario tiene que crear su cuenta antes de verificar
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    //Si el correo no esta verificado manda un mensaje de verficacion
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(//establece un contador de 3 segundos en verificar si ya esta verficado el contador
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  //Funcion para verificar el correo en espera a recibir un estado de verficación
  Future checkEmailVerified() async {
    //Manda a llamar verificacion de email y recarga 
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();//Si esta verifcado se cancel el contador 
  }
  
  /*
    Esta funcion hace que el mensaje de verificacion se enviado una vez que 
    el correo ingresa a la base de dados de firebase el cual usa como identificador
  */ 
  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfff70506),
            title: const Text('Verifica Correo Electrónico')),
          body: Padding(
            padding: EdgeInsets.all(16),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Link de verificación de correo a sido enviado',
                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              //Boton para reenviar el codigo
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xfff70506),
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(Icons.email, size: 32),
                label: const Text(
                  'Reenviar correo',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: canResendEmail ? sendVerificationEmail : null, //reenvia el link
              ),
              const SizedBox(height: 8),
              TextButton(
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size.fromHeight(50),
                ),
                child :Text('Cancelar',
                  style: TextStyle(fontSize: 24,color:Color(0xfff70506) ),
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),//Cancela y se sale al login de nuevo
                ),
            ]),
          ),
        );
}
