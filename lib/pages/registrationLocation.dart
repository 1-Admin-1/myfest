import 'dart:async';

import 'package:MyFest/Utils.dart';
import 'package:MyFest/Main.dart';
import 'package:MyFest/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:MyFest/models/dbModel.dart';

//Clase PageRegistration
//Registra a usuarios
// Create a Form widget.
class PageRegistrationLocation extends StatefulWidget {
  final Function() onClickedSignIn;

  const PageRegistrationLocation({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);
  @override
  MainFormState createState() => MainFormState();
}

// Holds data related to the form.
class MainFormState extends State<PageRegistrationLocation> {
  //Variables de controladores de textfield y llave de estado para el debugging
  final keyForm = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final nameNegocioCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final rfcCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final repeatPassCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final directionCtrl = TextEditingController();

  // Key that uniquely identifies the Form
  //Variables para elegir una imagen(Aun no implementado)
  final _imagePicker = ImagePicker();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Card(
          elevation: 16.0,
          margin:
              const EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                  validator: validateName,
                ),
                TextFormField(
                  controller: ageCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Edad (+18)',
                  ),
                  validator: validateAge,
                ),
                TextFormField(
                  controller: mobileCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Número. Telefono',
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: validateMobile,
                ),
                TextFormField(
                  controller: directionCtrl,
                  decoration: const InputDecoration(
                      labelText: "Dirección de Residencia"),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Porfavor ingresa de nuevo (min 5)';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nameNegocioCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre. Negocio',
                  ),
                  validator: validateName,
                ),
                TextFormField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: "Email"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Ingresa un correo valido'
                          : null,
                ),
                TextFormField(
                  controller: rfcCtrl,
                  decoration: const InputDecoration(labelText: "RFC"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validateRFC,
                ),
                TextFormField(
                  controller: passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Ingresa mínimo 6 caracteres'
                      : null,
                ),
                TextFormField(
                  controller: repeatPassCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Repetir la Contraseña',
                  ),
                  validator: validatePassword,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                Container(
                  height: 50,
                  width: 250,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff70506),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 32,
                    ),
                    label: const Text(
                      'Crear Cuenta',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: signUp,
                    // () {
                    //   Navigator.push(
                    //         context, MaterialPageRoute(builder: (_) => HomePage()));
                    // },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Funcion de validaciones Contraseña
  String? validatePassword(String? value) {
    if (kDebugMode) {
      print("valor $value passsword ${passwordCtrl.text}");
    }
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

//Funcion de validaciones Nombre
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

//Funcion de validaciones Numero Telefono
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

//Funcion de validaciones Correo
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

//Funcion de validaciones Edad
  String? validateAge(String? value) {
    int age = int.parse(value!);
    if (age < 18) {
      return "Necesitas ser mayor de 18";
    } else if (age > 100) {
      return "Edad invalida";
    }
    return null;
  }

//Funcion de validaciones RFC
  String? validateRFC(String? value) {
    String rfc = value!;
    if (rfc.length > 13) {
      return "RFC Incorrecto";
    } else if (rfc.length < 12) {
      return "RFC Incorrecto";
    }
    return null;
  }

//Funcion asincrona que espera a que los campos sean correctos para mandar
  FutureOr signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      //En espera para mandar el registron en donde hace una autenticacion con
      //Correo y contrasena
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailCtrl.text.trim(), password: passwordCtrl.text.trim());
      if (formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Procesando datos...')),
        );
      }
      //Manda el modelo de datos
      final users = UsersProviders(
        nombre: nameCtrl.text,
        nombreNegocio: nameNegocioCtrl.text,
        direccionResidencia: directionCtrl.text,
        email: emailCtrl.text,
        edad: int.parse(ageCtrl.text),
        numeroTelefono: mobileCtrl.text,
        rfc: rfcCtrl.text,
      );
      //Manda a llamar funcionpara crear usuario con sus registros personales
      createUser(users: users);
      
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e); //Imprime en consola el error
      Utils.showSnackBar(e.message); //Manda mensaje de error en pantalla
    }
    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  //Crea un doc por usuario en la colleccion de usuarios
  FutureOr createUser({required UsersProviders users}) async {
    final docUser =
        FirebaseFirestore.instance.collection('usersBusiness').doc(users.email);
    users.id = docUser.id;
    final json = users.toJson();
    await docUser.set(json);
  }
}
