//Routes
import 'dart:async';
import 'package:MyFest/models/dbModel.dart';
import 'package:MyFest/pages/home.dart';
import 'package:MyFest/pages/user.dart';
//Librerias
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
//Clase para editar fiestaa
class PageEdit extends StatefulWidget {
  Events events;

  PageEdit({Key? key, required this.events
      })
      : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<PageEdit> {
  //Variables de controladores
  final user = FirebaseAuth.instance.currentUser!;//variable de usuario logueado
  late final TextEditingController controllerTitle;
  late final TextEditingController controllerDescripcion;
  late final TextEditingController controllerFecha;
  late final TextEditingController controllerDireccion;
  late final TextEditingController controllerDireccionNumero;
  
  //Inicializar estado de contrladores
  @override
  void initState() {
    super.initState();

    controllerTitle = TextEditingController(text: widget.events.title);
    controllerDescripcion =
        TextEditingController(text: widget.events.descripcion);
    controllerDireccion = TextEditingController(text: widget.events.direccion);
    controllerDireccionNumero =
        TextEditingController(text: widget.events.numeroDireccion.toString());
    controllerFecha =
        TextEditingController(text: widget.events.fecha.toString());
  }

  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController namePartyCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController addressNumberCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

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
//Funcion de diseno 
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
              controller: controllerDireccionNumero,
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
                  context, MaterialPageRoute(builder: (_) => PageUser()));
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
                  //Actualiza datos de un evento en especifico con los campos adecuados
                  final docEvents = FirebaseFirestore.instance
                      .collection('events')
                      .doc(widget.events.id);
                  docEvents.update({
                    'title': controllerTitle.text,
                    'descripcion': controllerDescripcion.text,
                    'fecha': DateTime.parse(controllerFecha.text),
                    'direccion': controllerDireccion.text,
                    'numeroDireccion':
                        int.parse(controllerDireccionNumero.text),
                  });
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.add_box,
                  color: Colors.black,
                  size: 32,
                ),
                label: const Text(
                  "MODIFICAR",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )),
        const SizedBox(
          height: 10,
        ),
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
                        context, MaterialPageRoute(builder: (_) => const HomePage()));//Regresa a la pagina usuarios
                  },
                  child: const Text(
                    "Cancelar",
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
}
