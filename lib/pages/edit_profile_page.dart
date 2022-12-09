import 'dart:io';

import 'package:MyFest/models/dbModel.dart';
import 'package:MyFest/pages/home.dart';
import 'package:MyFest/pages/user.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:MyFest/models/userProfile.dart';
import 'package:MyFest/widgets/appbar_widget.dart';
import 'package:MyFest/widgets/button_widget.dart';
import 'package:MyFest/widgets/profile_widget.dart';
import 'package:MyFest/widgets/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  Users user;
  EditProfilePage({Key? key, required this.user
      })
      : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
   final users = FirebaseAuth.instance.currentUser!;
  late final TextEditingController controllerNombre;
  late final TextEditingController controllerTelefono;
  late final TextEditingController controllerEdad;
  late final TextEditingController controllerDireccion;
  late final TextEditingController controllerEmail;
  
  
  @override
  void initState() {
    super.initState();
    
    controllerNombre = TextEditingController(text: widget.user.nombre);
    controllerDireccion = TextEditingController(text: widget.user.direccionResidencia);
    controllerTelefono = TextEditingController(text: widget.user.numeroTelefono);
    controllerEdad = TextEditingController(text: widget.user.edad.toString());
    controllerEmail = TextEditingController(text: widget.user.email);
  }

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController namePartyCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: '',
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nombre Completo',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controllerNombre,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 1,
                      validator: validateName,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Edad',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controllerEdad,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 1,
                      validator: validateAge,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Correo Electrónico',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      enabled: false,
                      controller: controllerEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 1,
                      validator: validateEmail,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Num. Teléfono',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controllerTelefono,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 1,
                      validator: validateMobile,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Domicilio',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controllerDireccion,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 1,
                      validator:  (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Porfavor ingresa de nuevo (min 5)';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                Container(
                  height: 50,
                  width: 250,
                  child: 
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff70506),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(
                      Icons.arrow_upward,
                      size: 32,
                    ),
                    label: const Text(
                      'Actualizar',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: (){
                      // If the form is true (valid), or false.
                        
                        final docEvents = FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.user.email);
                            docEvents.update({
                              'nombre': controllerNombre.text,
                              'edad': int.parse(controllerEdad.text),
                              'direccionResidencia': controllerDireccion.text,
                              'numeroTelefono': controllerTelefono.text,
                        });
                        Navigator.pop(context);
                    }
                  
                ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 250,
                  child: 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff70506),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text(
                      'Regresar',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: 
                    () {
                      Navigator.push(
                            context, MaterialPageRoute(builder: (_) => const HomePage()));
                    },
                  ),
                  
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );


      String? validateName(String? value) {
      String pattern = r'(^[a-zA-Z ]*$)';
      RegExp regExp = RegExp(pattern);
      if (value?.length == 0) {
        return "El nombre es necesario";
      } else if (!regExp.hasMatch(value!)) {
        return "El nombre debe de ser a-z y A-Z";
      }
      return null;
    }

    String? validateMobile(String? value) {
      String patttern = r'(^[0-9]*$)';
      RegExp regExp = RegExp(patttern);
      if (value?.length == 0) {
        return "El telefono es necesario";
      } else if (value?.length != 10) {
        return "El numero debe tener 10 digitos";
      }
      return null;
    }

    String? validateEmail(String? value) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (value?.length == 0) {
        return "El correo es necesario";
      } else if (!regExp.hasMatch(value!)) {
        return "Correo invalido";
      } else {
        return null;
      }
    }

    String? validateAge(String? value) {
      int age = int.parse(value!);
      if (age < 18) {
        return "Necesitas ser mayor de 18";
      } else if (age > 100) {
        return "Edad invalida";
      }
      return null;
    }

}
