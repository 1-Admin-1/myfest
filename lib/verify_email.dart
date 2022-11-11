import 'dart:async';

import 'package:MyFest/Utils.dart';
import 'package:MyFest/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPage createState() => _VerifyEmailPage();
}

class _VerifyEmailPage extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    //user needs to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
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

  Future checkEmailVerified() async {
    // call after email verification
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
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
                onPressed: canResendEmail ? sendVerificationEmail : null,
              ),
              const SizedBox(height: 8),
              TextButton(
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size.fromHeight(50),
                ),
                child :Text('Cancelar',
                  style: TextStyle(fontSize: 24,color:Color(0xfff70506) ),
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),
                ),
            ]),
          ),
        );
}
