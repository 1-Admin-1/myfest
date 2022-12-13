///Librerias
import 'package:MyFest/models/dbModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///Clase NumbersWidget
///Esta se usara para sacar cantidades de fiestas creadas y sus calificaciones
///AUN NO ESTA IMPLEMENTADO
class NumbersWidget extends StatelessWidget {
 NumbersWidget( {Key? key, }) : super(key: key);
 
 //Variable para ver el usaurio que esta logeado
  final user = FirebaseAuth.instance.currentUser!;

  
Stream<List<Events>> readEvents() => FirebaseFirestore.instance
      .collection('events')
      .where('user_email', isEqualTo: user.email)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Events.fromJson(doc.data())).toList());
  @override
  Widget build(BuildContext context) => StreamBuilder<List<Events>>(
    
      stream: readEvents(), // mandar a llamar la funcion para extraer datos
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //si hubo error al extraer los datos
          return Text('Hubo un problema! ${snapshot.error}');
        } else if (snapshot.hasData) {
          ///si hay datos
          final events = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              buildButton(context, snapshot.data!.length,'Fiestas'),
            ],
            
          );
        } else {
          //Texto de manda para decir al usuario que no hay fiestas creadas
          return const Padding(
            padding: EdgeInsets.only(left: 50.0),
            child: Text(
              "0",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          );
        }
      },  
      
      );
  Widget buildDivider() => Container(
        height: 24,
        child: const VerticalDivider(),
      );

  Widget buildButton(BuildContext context,int count, String text) => MaterialButton(

        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              count.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
