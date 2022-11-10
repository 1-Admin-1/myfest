import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:MyFest/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:MyFest/db/operation.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class PageCreate extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<PageCreate> {
  final controllerTitle = TextEditingController();
  final controllerDescripcion = TextEditingController();
  final controllerFecha = TextEditingController();
  final controllerDireccion = TextEditingController();
  final controllerDirecionNumero = TextEditingController();
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController namePartyCtrl = new TextEditingController();
  TextEditingController addressCtrl = new TextEditingController();
  TextEditingController addressNumberCtrl = new TextEditingController();
  TextEditingController descriptionCtrl = new TextEditingController();


  Future createUser({required Events events}) async {
    final docUser = FirebaseFirestore.instance.collection('events').doc();
    events.id = docUser.id;
    final json = events.toJson();
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Crear Fiesta'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(40.0),
            child: new Form(
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
      padding: EdgeInsets.symmetric(vertical: 7),
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
              decoration: new InputDecoration(
                labelText: 'Nombre de la Fiesta',
              ),
              validator: validateNameParty,
            )),
        formItemsDesign(
            Icons.location_pin,
            TextFormField(
              controller: controllerDireccion,
              decoration: new InputDecoration(
                labelText: 'Dirección',
              ),
              keyboardType: TextInputType.streetAddress,
              validator: validateAddress,
            )),
        formItemsDesign(
            Icons.location_pin,
            TextFormField(
              controller: controllerDirecionNumero,
              decoration: new InputDecoration(
                labelText: 'Numero de Dirección',
              ),
              keyboardType: TextInputType.text,
              validator: validateAddressNumber,
            )),
        formItemsDesign(
            Icons.mode_comment,
            TextFormField(
              controller: controllerDescripcion,
              decoration: new InputDecoration(
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
              decoration: new InputDecoration(
                labelText: 'Fecha de Evento',
              ),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime.now().add(new Duration(days: 30)));
              },
            )),
        GestureDetector(
            onTap: () {
              save();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            },
            child: Container(
              margin:
                  new EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  Color(0xFF0EDED2),
                  Color(0xFF03A0FE),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // If the form is true (valid), or false.
                  if (keyForm.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                  final events = Events(
                      title: controllerTitle.text,
                      descripcion: controllerDescripcion.text,
                      fecha: DateTime.parse(controllerFecha.text),
                      direccion: controllerDireccion.text,
                      numeroDireccion:
                          int.parse(controllerDirecionNumero.text));
                  createUser(events: events);
                  Navigator.pop(context);
                },
                child: const Text("PUBLICAR"),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
            )),
        GestureDetector(
            child: Container(
                margin: new EdgeInsets.only(
                    left: 30, right: 30, top: 0, bottom: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Color(0xFF0EDED2),
                    Color(0xFF193073),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: TextButton(
                  onPressed: () {
                    // If the form is true (valid), or false.
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                  ),
                  child: const Text("Cancelar"),
                )))
      ],
    );
  }

  String? validateNameParty(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value!)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  String? validateAddress(String? value) {
    String patttern = r'^[a-zA-Z]*$';
    RegExp regExp = new RegExp(patttern);
    if (value?.length == 0) {
      return "La dirección es necesaria";
    } else if (!regExp.hasMatch(value!)) {
      return "Dirección invalida";
    }
    return null;
  }

  String? validateAddressNumber(String? value) {
    String patttern = r'^[a-zA-Z0-9]*$';
    RegExp regExp = new RegExp(patttern);
    if (value?.length == 0) {
      return "El numero es necesario";
    } else if (!regExp.hasMatch(value!)) {
      return "Numero de Dirección invalida";
    }
    return null;
  }

  String? validateDescription(String? value) {
    String pattern = r'^[a-zA-Z0-9]*$';
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return "La descripcion es necesaria";
    } else if (!regExp.hasMatch(value!)) {
      return "Descripción es invalida";
    } else {
      return null;
    }
  }

  save() {
    if (keyForm.currentState!.validate()) {
      print("Nombre ${namePartyCtrl.text}");
      print("Dirección ${addressCtrl.text}");
      print("Numero ${addressNumberCtrl.text}");
      print("Descripción ${descriptionCtrl.text}");
      Operation.insert(Note(
          title: namePartyCtrl.text,
          description: descriptionCtrl.text,
          address: addressCtrl.text,
          addressNumber: addressNumberCtrl.text));
      keyForm.currentState!.reset();
    }
  }
}

class Events {
  late String id;
  late final String title;
  late final String descripcion;
  late final DateTime fecha;
  late final String direccion;
  late final int numeroDireccion;
  Events({
    this.id = '',
    required this.title,
    required this.descripcion,
    required this.fecha,
    required this.direccion,
    required this.numeroDireccion,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'descripcion': descripcion,
        'fecha': fecha,
        'direccion': direccion,
        'numeroDireccion': numeroDireccion,
      };
  
}
