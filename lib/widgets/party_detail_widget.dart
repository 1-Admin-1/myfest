///Librerias
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Routes
import '../bloc/cart_bloc.dart';
import '../bloc/event/cart_event.dart';
import '../models/dbModel.dart';
import 'count_controller.dart';
import 'package:MyFest/app_theme.dart';
import 'package:MyFest/widgets/button.dart';

///Clase PartyDetailWidget
///Muestra detalle de cada evento
class PartyDetailWidget extends StatefulWidget {
  ///necesario mandar a llamar una variable del modelo Events
  const PartyDetailWidget({Key? key, required this.events}) : super(key: key);

  final Events events;

  @override
  _PartyDetailWidgetState createState() => _PartyDetailWidgetState();
}

class _PartyDetailWidgetState extends State<PartyDetailWidget>
    with TickerProviderStateMixin {
  ///Variable que ayuda a identificar quien esta logeado en tiempo real
  final user = FirebaseAuth.instance.currentUser!;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int? countControllerValue;

  ///contador de valor

  ///Funcion para mandar llamadar una lista de datos de manera asincrona desde firebase
  ///leer los usuarios que hay en la base de datos
  ///solo hace la lecutra una vez de coleccion y documento especifico
  ///Con esto hacemos lectura de quien asistio
  Future<Users?> readUsersOne() async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(user.email);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return Users.fromJson(snapshot.data()!);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  ///Crear lista de asistencia e ingresar datos al evento especifico
  Future createList({required Attendance attendance}) async {
    print(attendance.id);
    final docUser = FirebaseFirestore.instance
        .collection('events') //coleccion
        .doc(attendance.id) //obtener el id del evento
        .collection('listAttendance') //crear lista de asistencia
        .doc(); //crear doc con id automatico para la estructura de Attendance
    // attendance.id = docUser.id;
    final json = attendance.toJson();
    await docUser.set(json); //en espera para recibir en el json
  }

  Future listUserAttendance({required AttendanceUserProfile attendance}) async {
    final docUser = FirebaseFirestore.instance
        .collection('users') //coleccion
        .doc(user.email)
        .collection('eventAttendance') //lista de asistencia por usuario
        .doc();
    attendance.id = docUser.id;
    final json = attendance.toJson();
    await docUser.set(json); //en espera para recibir en el json
  }

  //Muestra dialogo de confirmacion
  showAlertDialog(
      {required AttendanceUserProfile events,
      required Attendance attendance}) async {
    print(attendance.id);
    final QuerySnapshot eventSnapshot = await FirebaseFirestore.instance
        .collection('events')
        .where('id', isEqualTo: attendance.id)
        .get();
    final List<QueryDocumentSnapshot> eventDocs = eventSnapshot.docs;

    if (eventDocs.isNotEmpty) {
      final QuerySnapshot attendanceSnapshot = await eventDocs[0]
          .reference
          .collection('listAttendance')
          .where('user_email', isEqualTo: user.email)
          .get();
      final List<QueryDocumentSnapshot> attendanceDocs =
          attendanceSnapshot.docs;

      if (attendanceDocs.isNotEmpty) {
        // set up the buttons
        Widget cancelButton = ElevatedButton(
            child: const Text("Cerrar"),
            onPressed: () => Navigator.pop(context));

        AlertDialog alert = AlertDialog(
          title: const Text("Ya tienes boleto"),
          content: const Text(
              "Si quieres mas boletos, necesitas cnacelar y volver a asistir"),
          actions: [cancelButton],
        ); // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        print('Invitacion existe');
      } else {
        createList(
            attendance:
                attendance); //Manda el modelo a la funcion con los datos para guardar
        listUserAttendance(attendance: events);
        print(
            'No se encontró ningún documento de asistencia para el usuario especificado');
      }
    } else {
      print('No se encontró ningún documento de evento con el ID especificado');
    }
  }

  @override
  Widget build(BuildContext context) {
    String fechaaux = widget.events.fecha.toString();
    String fecha;

    fecha = fechaaux.replaceAll("00:00:00.000",
        ""); //remplaza los datos innecesarios para mostrar lo importante
    //Retorna en futuro hasta que reciba usuarios
    return FutureBuilder<Users?>(
      future: readUsersOne(), //funcion para leer los usuarios
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //si hay error
          return Text('Hubo un problema! ${snapshot.error}');
        } else if (snapshot.hasData) {
          //si tiene datos
          final users = snapshot.data!;
          return Scaffold(
            key: scaffoldKey, //llave del estado
            appBar: AppBar(
              backgroundColor: Color(0xff453658),
              automaticallyImplyLeading: false,
              leading: InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              title: Text(
                ' ${widget.events.title}', //imprimir titulo
                style: AppTheme.of(context).subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xfff70506),
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            backgroundColor: Color(0xff453658),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: Hero(
                            tag: 'mainImage',
                            transitionOnUserGestures: true,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/logoNombre.png', //imagen de deafult(personalizada en la siguiente version)
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            child: Row(
                              children: [
                                const Text('Dirección: ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                Text(
                                  widget.events.direccion, //imprimir direccion
                                  style: AppTheme.of(context).title1,
                                ),
                                const Text('  Número: ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                Text(
                                  widget.events.numeroDireccion.toString(),
                                  style: AppTheme.of(context).title1,
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Row(
                            children: [
                              const Text('Fecha: ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                              Text(
                                fecha,
                                style: AppTheme.of(context).title1,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                          child: Text(
                            'Descripción',
                            textAlign: TextAlign.start,
                            style: AppTheme.of(context).title4,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Text(
                            widget.events.descripcion, //imprimir descripcion
                            style: AppTheme.of(context).bodyText5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Bottom app bar
                /// Esta parte es la del contador y crear asistencia en por persona
                Material(
                  color: Colors.transparent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xff453658),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x320F1113),
                          offset: Offset(0, -2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 34),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: AppTheme.of(context).primaryBackground,
                                width: 2,
                              ),
                            ),
                            //COntador de aumento y decenso del valor
                            child: CountController(
                              decrementIconBuilder: (enabled) => Icon(
                                Icons.remove_rounded,
                                color: enabled
                                    ? AppTheme.of(context).secondaryText
                                    : AppTheme.of(context).secondaryText,
                                size: 25,
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 0.0, right: 0.0),
                              incrementIconBuilder: (enabled) => Icon(
                                Icons.add_rounded,
                                color: enabled
                                    ? AppTheme.of(context).primaryColor
                                    : AppTheme.of(context).secondaryText,
                                size: 25,
                              ),
                              countBuilder: (count) => Text(
                                count.toString(),
                                style: AppTheme.of(context).subtitle1,
                              ),
                              count: countControllerValue ??= 1,
                              //actualizar contador
                              updateCount: (count) =>
                                  setState(() => countControllerValue = count),
                              stepSize: 1,
                              minimum: 1,
                            ),
                          ),
                          //Boton para asistir que andara los valores del usuario junto con el valor que la
                          // cantidad de asistentes
                          MyButtonWidget(
                            text: 'ASISTIR',
                            options: ButtonOptions(
                                width: 140,
                                height: 50,
                                color: const Color(0xfff70506),
                                textStyle:
                                    AppTheme.of(context).subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                elevation: 5,
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36))),
                            onPressed: () {
                              //Cuando presione manda datos a la funcion crear lista
                              final attendance = Attendance(
                                  nombre: users.nombre,
                                  userEmail: user.email!,
                                  cantidadPersonas: countControllerValue!,
                                  id: widget.events.id);
                              final attendanceUserProfile =
                                  AttendanceUserProfile(
                                      nombre: users.nombre,
                                      userEmail: user.email!,
                                      cantidadPersonas: countControllerValue!,
                                      idEvent: widget.events.id,
                                      title: widget.events.title);
                              showAlertDialog(
                                  events: attendanceUserProfile,
                                  attendance: attendance);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          //Circulo de carga
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
