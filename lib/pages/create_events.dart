import 'dart:async';
import 'package:MyFest/Utils.dart';
import 'package:MyFest/models/dataEvents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class PageCreate extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<PageCreate> {
  final user = FirebaseAuth.instance.currentUser!;
  final controllerTitle = TextEditingController();
  final controllerDescripcion = TextEditingController();
  final controllerFecha = TextEditingController();
  final controllerDireccion = TextEditingController();
  final controllerDirecionNumero = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController namePartyCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController addressNumberCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();


  Future createEvent({required Events events}) async {
    final docUser = FirebaseFirestore.instance.collection('events').doc();
    events.id = docUser.id;
    final json = events.toJson();
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Crear Fiesta'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(40.0),
            child: Form(
              key: keyForm,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        formItemsDesign(
            Icons.celebration_rounded,
            TextFormField(
              controller: controllerTitle,
              decoration: const InputDecoration(
                labelText: 'Nombre de la Fiesta',
              ),
              validator: validateNameParty,
            )),
        formItemsDesign(
            Icons.location_pin,
            TextFormField(
              controller: controllerDireccion,
              decoration: const InputDecoration(
                labelText: 'Dirección',
              ),
              keyboardType: TextInputType.streetAddress,
              validator: validateAddress,
            )),
        formItemsDesign(
            Icons.location_pin,
            TextFormField(
              controller: controllerDirecionNumero,
              decoration: const InputDecoration(
                labelText: 'Numero de Dirección',
              ),
              keyboardType: TextInputType.text,
              validator: validateAddressNumber,
            )),
        formItemsDesign(
            Icons.mode_comment,
            TextFormField(
              controller: controllerDescripcion,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
              keyboardType: TextInputType.text,
              validator: validateDescription,
            )),
        formItemsDesign(
            Icons.celebration_rounded,
            DateTimeField(
              format: DateFormat("yyyy-MM-dd"),
              controller: controllerFecha,
              decoration: const InputDecoration(
                labelText: 'Fecha de Evento',
              ),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)));
              },
            )),
        GestureDetector(
            onTap: () {
              // save();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const HomePage()));
            },
            child: Container(
              height: 50,
              width: 300,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff70506),
                      minimumSize: const Size.fromHeight(50),
                    ),
                onPressed: () {
                  // If the form is true (valid), or false.
                  if (keyForm.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Procesando Datos')),
                    );
                  }
                  final events = Events(
                      title: controllerTitle.text,
                      descripcion: controllerDescripcion.text,
                      fecha: DateTime.parse(controllerFecha.text),
                      direccion: controllerDireccion.text,
                      numeroDireccion: int.parse(controllerDirecionNumero.text),
                      userEmail: user.email!);
                  createEvent(events: events);
                  Navigator.pop(context);
                },
                icon: const Icon(
                    Icons.add_box,
                    color: Colors.black,
                    size: 32,
                  ),
                label: const Text("PUBLICAR",
                style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),),

                // style: TextButton.styleFrom(
                //     padding: EdgeInsets.only(top: 16, bottom: 16),
                //     textStyle: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 18,
                //         fontWeight: FontWeight.w500)),
              ),
            )
            ),
            const SizedBox(height: 10,),
        GestureDetector(
            child: Container(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff70506),
                      minimumSize: const Size.fromHeight(50),
                    ),
                  onPressed: () {
                    // If the form is true (valid), or false.
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const HomePage()));
                  },

                  child: const Text("Cancelar",
                  style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                   ),


                )))
      ],
    );
  }

  String? validateNameParty(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.length == 0) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value!)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  String? validateAddress(String? value) {
    String patttern = r'^[a-zA-Z]*$';
    RegExp regExp = RegExp(patttern);
    if (value?.length == 0) {
      return "La dirección es necesaria";
    } else if (!regExp.hasMatch(value!)) {
      return "Dirección invalida";
    }
    return null;
  }

  String? validateAddressNumber(String? value) {
    String patttern = r'^[a-zA-Z0-9]*$';
    RegExp regExp = RegExp(patttern);
    if (value?.length == 0) {
      return "El numero es necesario";
    } else if (!regExp.hasMatch(value!)) {
      return "Numero de Dirección invalida";
    }
    return null;
  }

  String? validateDescription(String? value) {
    String pattern = r'^[a-zA-Z0-9]*$';
    RegExp regExp = RegExp(pattern);
    if (value?.length == 0) {
      return "La descripcion es necesaria";
    } else if (!regExp.hasMatch(value!)) {
      return "Descripción es invalida";
    } else {
      return null;
    }
  }

  // save() {
  //   if (keyForm.currentState!.validate()) {
  //     print("Nombre ${namePartyCtrl.text}");
  //     print("Dirección ${addressCtrl.text}");
  //     print("Numero ${addressNumberCtrl.text}");
  //     print("Descripción ${descriptionCtrl.text}");
  //     Operation.insert(Note(
  //         title: namePartyCtrl.text,
  //         description: descriptionCtrl.text,
  //         address: addressCtrl.text,
  //         addressNumber: addressNumberCtrl.text));
  //     keyForm.currentState!.reset();
  //   }
  // }
}

// class Events {
//   late String id;
//   late final String title;
//   late final String descripcion;
//   late final DateTime fecha;
//   late final String direccion;
//   late final int numeroDireccion;
//   Events({
//     this.id = '',
//     required this.title,
//     required this.descripcion,
//     required this.fecha,
//     required this.direccion,
//     required this.numeroDireccion,
//   });
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'descripcion': descripcion,
//         'fecha': fecha,
//         'direccion': direccion,
//         'numeroDireccion': numeroDireccion,
//       };

// }
