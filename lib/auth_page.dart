import 'package:MyFest/login.dart';
import 'package:MyFest/registration.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin 
    ? Login(onClickedSignUp: toggle) 
    : PageRegistration(onClickedSignIn: toggle);

    void toggle()=> setState(() => isLogin =!isLogin);
}
