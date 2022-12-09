import 'dart:async';
import 'package:MyFest/Utils.dart';
import 'package:MyFest/Main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/forgot_password_page.dart';
import 'registration.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const Login({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<Login> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xfff70506),
                  Color(0xff080404),
                  Color(0xff080404)
                ],
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 150),
                const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/playstore.png'),
                      backgroundColor: Color(0xff080404),
                      radius: 100,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0),
                  child: TextField(
                    controller: controllerEmail,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xffeaeaea),
                      contentPadding: EdgeInsets.all(20),
                      labelText: 'Correo electrónico',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: controllerPassword,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffeaeaea),
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff70506),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(
                      Icons.lock_open,
                      size: 32,
                    ),
                    label: const Text(
                      'Iniciar Sesion',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: signIn,
                    // () {
                    //   Navigator.push(
                    //         context, MaterialPageRoute(builder: (_) => HomePage()));
                    // },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                  )),
                  child: const Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: Color(0xfff70506), fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 100),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    text: '¿Nuevo Usuario?',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: 'Crear cuenta nueva',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 131, 43, 43),
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    
    try {
      await _auth.signInWithEmailAndPassword(
        email: controllerEmail.text.trim(),
        password: controllerPassword.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
