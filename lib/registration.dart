import 'package:MyFest/Utils.dart';
import 'package:MyFest/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:MyFest/models/dataEvents.dart';

// Create a Form widget.
class PageRegistration extends StatefulWidget {
  final Function() onClickedSignIn;

  const PageRegistration({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);
  @override
  MainFormState createState() => MainFormState();
}

// Holds data related to the form.
class MainFormState extends State<PageRegistration> {
  final keyForm = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final repeatPassCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final directionCtrl = TextEditingController();

  // Key that uniquely identifies the Form
  final _imagePicker = ImagePicker();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Card(
          elevation: 16.0,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      _pickedImage != null ? FileImage(_pickedImage!) : null,
                ),
                TextButton.icon(
                    onPressed: () async {
                      final img = await _imagePicker.pickImage(
                          source: ImageSource.camera);
                      setState(() {
                        _pickedImage = File(img!.path);
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    icon: const Icon(Icons.image),
                    label: const Text('Añadir foto')),
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
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: "Email"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Ingresa un correo valido'
                          : null,
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
                  child: 
                  ElevatedButton.icon(
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
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      text: '¿Ya tienes cuenta?',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                          text: 'Iniciar sesión',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 131, 43, 43),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    if (kDebugMode) {
      print("valor $value passsword ${passwordCtrl.text}");
    }
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

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

  // save() {
  //   if (keyForm.currentState!.validate()) {
  //     print("Nombre ${nameCtrl.text}");
  //     print("Telefono ${mobileCtrl.text}");
  //     print("Correo ${emailCtrl.text}");
  //     keyForm.currentState!.reset();
  //   }
  // }

  Future signUp() async {

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
         
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailCtrl.text.trim(), password: passwordCtrl.text.trim());
          if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Procesando datos...')),
                    );
                  }
                  final users = Users(
                    numeroTelefono: mobileCtrl.text, 
                    direccionResidencia: directionCtrl.text, 
                    edad: int.parse(ageCtrl.text), 
                    email: emailCtrl.text, 
                    nombre: nameCtrl.text,
                      );
                  createUser(users: users);
                  Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      
        print(e);
        Utils.showSnackBar(e.message);
    }
    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

   Future createUser({required Users users}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    users.id = docUser.id;
    final json = users.toJson();
    await docUser.set(json);
  }

}


        
 