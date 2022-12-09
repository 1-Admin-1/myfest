import 'package:MyFest/pages/login.dart';
import 'package:MyFest/pages/registration.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
//Clase de autenticacion

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}
//Verifica si el usuario se puede loguear
class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin 
    ? Login(onClickedSignUp: toggle) 
    : PageRegistration(onClickedSignIn: toggle);

    void toggle()=> setState(() => isLogin =!isLogin);
}
