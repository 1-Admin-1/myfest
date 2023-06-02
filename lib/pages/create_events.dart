import 'dart:async';
import 'package:MyFest/Utils.dart';
import 'package:MyFest/models/dbModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

//Clase para crea fiesta
class PageCreate extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<PageCreate> {
  List<String>? nombresNegocio;
  List<String>? emailNegocio;
  List<String>? direccionNegocio;
  late String numeroUsuario;

  @override
  void initState() {
    super.initState();
    obtenerNombresNegocio().then((map) {
      setState(() {
        nombresNegocio = map['nombresNegocio'];
        emailNegocio = map['emailNegocio'];
        direccionNegocio = map['direccionResidencia'];
      });
    });
    getDatoCampoEspecifico().then((value) {
      setState(() {
        numeroUsuario = value;
      });
    });
  }

  String? selectedNombreNegocio;
  String? selectedEmailNegocio;
  String? selectedDireccionNegocio;
  //Variable de controladores
  final user =
      FirebaseAuth.instance.currentUser!; //Variable de usuario logueado
  final controllerTitle = TextEditingController();
  final controllerDescripcion = TextEditingController();
  final controllerFecha = TextEditingController();
  final controllerDireccion = TextEditingController();

  GlobalKey<FormState> keyForm = GlobalKey();

// //Funcion para crea evento en base a un modelo de objetos
//   FutureOr createEvent({required Events events}) async {
//     final docUser = FirebaseFirestore.instance.collection('events').doc();
//     events.id = docUser.id;
//     final json = events.toJson();
//     await docUser.set(json);
//   }

  FutureOr createEventCalendar({required EventDate eventDate, required Events events}) async {
    final docUser2 = FirebaseFirestore.instance.collection('events').doc();
    events.id = docUser2.id;
    final json2 = events.toJson();
    await docUser2.set(json2);
    final docUser = FirebaseFirestore.instance
        .collection('usersBusiness')
        .doc(selectedEmailNegocio)
        .collection('agenda')
        .doc();
    eventDate.id = docUser.id;
    eventDate.numeroTelefono = numeroUsuario;
    eventDate.idEvent =  docUser2.id;
    final json = eventDate.toJson();
    await docUser.set(json);
  }

  Future<String> getDatoCampoEspecifico() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference =
        firestore.collection('users').doc(user.email);
    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      String campoDeseado = data!['numeroTelefono'];
      return campoDeseado;
    }

    return ''; // En caso de no encontrar el campo o documento
  }

  Future<Map<String, List<String>>> obtenerNombresNegocio() async {
    List<String> nombresNegocio = [];
    List<String> emailNegocio = [];
    List<String> direccionNegocio = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('usersBusiness').get();

    querySnapshot.docs.forEach((doc) {
      nombresNegocio.add(doc['nombreNegocio']);
      emailNegocio.add(doc['email']);
      direccionNegocio.add(doc['direccionResidencia']);
    });

    return {
      'nombresNegocio': nombresNegocio,
      'emailNegocio': emailNegocio,
      'direccionResidencia': direccionNegocio,
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Crear Fiesta',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(40.0),
            child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    formUI(),
                  ],
                )),
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
          Icons.celebration_rounded,
          FutureBuilder<Map<String, List<String>>>(
            future: obtenerNombresNegocio(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, List<String>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<String>? nombresNegocio = snapshot.data!['nombresNegocio'];
                List<String>? emailNegocio = snapshot.data!['emailNegocio'];
                List<String>? direccionNegocio =
                    snapshot.data!['direccionResidencia'];
                List<String> dropdownItems = nombresNegocio ?? [];
                return DropdownButton<String>(
                  value: selectedNombreNegocio,
                  hint: const Text('Elige localización'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedNombreNegocio = newValue;
                      int selectedIndex = nombresNegocio!.indexOf(newValue!);
                      selectedEmailNegocio = emailNegocio![selectedIndex];
                      controllerDireccion.text =
                          direccionNegocio![selectedIndex];
                    });
                  },
                  items: dropdownItems.map((String nombre) {
                    int index = nombresNegocio!.indexOf(nombre);
                    String email = emailNegocio![index];
                    return DropdownMenuItem<String>(
                      value: nombre, // Enviar el correo electrónico como valor
                      child: Text(nombre), // Mostrar solo el nombre del negocio
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
        formItemsDesign(
          Icons.location_pin,
          TextFormField(
            controller: controllerDireccion,
            decoration: InputDecoration(
              labelText: 'Dirección',
            ),
            keyboardType: TextInputType.streetAddress,
            validator: validateAddress,
          ),
        ),
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
        const SizedBox(
          height: 20,
        ),
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
                  //manda toda la informacion de los controladores a un modelo
                  //para asi mandarlo a una funcion de crear eventos
                  final events = Events(
                      title: controllerTitle.text,
                      descripcion: controllerDescripcion.text,
                      fecha: DateTime.parse(controllerFecha.text),
                      direccion: controllerDireccion.text,
                      userEmail: user.email!,
                      location: selectedNombreNegocio!);
                  String? direccion = controllerDireccion.text;
                  final eventDate = EventDate(
                      title: controllerTitle.text,
                      descripcion: controllerDescripcion.text,
                      fecha: DateTime.parse(controllerFecha.text),
                      direccion: direccion,
                      userEmail: user.email!,
                      location: selectedNombreNegocio!);
                  createEventCalendar(eventDate: eventDate,events: events);
                  // createEvent(events: events); //funcion para crear eventos
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.add_box,
                  color: Colors.black,
                  size: 32,
                ),
                label: const Text(
                  "PUBLICAR",
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
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const HomePage())); //regresa al home page
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

//Validaciones

//Validacion de nombre
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

//Validacion de direccion
  String? validateAddress(String? value) {
    if (selectedNombreNegocio!.isNotEmpty) {
      return null;
    } else {
      String patttern = r'^[a-zA-Z]*$';
      RegExp regExp = RegExp(patttern);
      if (value?.length == 0) {
        return "La dirección es necesaria";
      } else if (!regExp.hasMatch(value!)) {
        return "Dirección invalida";
      }
      return null;
    }
  }

//Validacion de numero de direccion
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

//Validacion de descripcion
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
