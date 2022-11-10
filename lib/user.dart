

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_required.dart';
import 'user_preferences.dart';
import 'appbar_widget.dart';
import 'button_widget.dart';
import 'numbers_widget.dart';
import 'profile_widget.dart';

class PageUser extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PageUser> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final userJson = UserPreferences.myUser;

    return Scaffold(
      
      body: ListView(
        
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(left: 250),
            child:ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff212328),
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.arrow_back), 
              label: Text(
                'Cerrar Sesion',
                style: TextStyle(color: Color(0xfff70506)),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),

            ),
          ),
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: userJson.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Text(
                'Admin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                user.email!,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          // buildAbout(userJson),
        ],
      ),
    );
  }

  // Widget buildName(UserJson user) => Column(
  //       children: [
  //         Text(
  //           user.name,
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //         ),
  //         const SizedBox(height: 4),
  //         Text(
  //           user.email,
  //           style: TextStyle(color: Colors.grey),
  //         )
  //       ],
  //     );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Edit',
        onClicked: () {},
      );

//   Widget buildAbout(User user) => Container(
//         padding: EdgeInsets.symmetric(horizontal: 48),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'About',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               user.about,
//               style: TextStyle(fontSize: 16, height: 1.4),
//             ),
//           ],
//         ),
//       );
 }