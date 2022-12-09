import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => ElevatedButton(
          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent)) ,
          child: const Text("Cerrar Sesión"),
          onPressed: () => FirebaseAuth.instance.signOut(), 
        ),
      ),
    ],
  );
}
