import 'package:MyFest/Utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xfff70506), Color(0xff080404), Color(0xff080404)],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child:Form(
            key: formKey,
            child: Column(
            children: <Widget>[
              const SizedBox(height: 300),
              const Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Text(
                    'Recibirás un correo para restaurar contraseña',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0),
                child: TextFormField(
                  controller: emailCtrl,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Ingresa un correo valido'
                          : null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xffeaeaea),
                    contentPadding: EdgeInsets.all(20),
                    labelText: 'Correo electrónico',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff70506),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(
                    Icons.email_outlined,
                    size: 32,
                  ),
                  label: const Text(
                    'Restaurar Contraseña',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: resetPassword,
                  // () {
                  //   Navigator.push(
                  //         context, MaterialPageRoute(builder: (_) => HomePage()));
                  // },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          )
          
        ),
      ),
    );
  }

  Future resetPassword() async {
     final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailCtrl.text.trim());
      Utils.showSnackBar('Correo para Restauración de contraseña fue enviado');
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
