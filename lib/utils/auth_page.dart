//Librerías
import 'package:MyFest/pages/registrationLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Routes
import 'package:MyFest/pages/login.dart';
import 'package:MyFest/pages/registration.dart';

//Clase de autenticacion

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}
//Verifica si el usuario se puede loguear
class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  
  bool isRegistration = true;

  @override
  Widget build(BuildContext context) => isLogin 
    ? Login(onClickedSignUp: toggle) 
    : isRegistration
      ? PageRegistration(onClickedSignIn: toggle)
      : PageRegistrationLocation(onClickedSignIn: toggle);

    void toggle()=> setState(() => isLogin =!isLogin);
}
