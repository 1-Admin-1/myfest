import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
//Modelo de la base de datos que se manda a Firebase Store

class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  int quantity;

  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      this.quantity = 0});
}

//Clase que da modelo a la base de datos y con lo que mandamos los datos
//Esta clase es para datos principales de cada evento
class Events {
  late String id;
  String title;
  String descripcion;
  DateTime fecha;
  String direccion;
  String userEmail;
  late String location;

  Events(
      {this.id = '',
      this.location = '',
      required this.title,
      required this.descripcion,
      required this.fecha,
      this.direccion = '',
      required this.userEmail});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'descripcion': descripcion,
        'fecha': fecha,
        'direccion': direccion,
        'user_email': userEmail,
        'location': location,
      };
  static Events fromJson(Map<String, dynamic> json) => Events(
        id: json['id'],
        title: json['title'],
        descripcion: json['descripcion'],
        fecha: (json['fecha'] as Timestamp).toDate(),
        direccion: json['direccion'],
        userEmail: json['user_email'],
        location: json['location'],
      );
}

class EventDate {
  late String id;
  late String nombre;
  String title;
  String descripcion;
  DateTime fecha;
  String direccion;
  String userEmail;
  late String location;
  String numeroTelefono;
  late String idEvent;

  EventDate(
      {this.id = '',
      this.location = '',
      this.nombre = '',
      required this.title,
      this.numeroTelefono = '',
      required this.descripcion,
      required this.fecha,
      this.direccion = '',
      required this.userEmail,
      this.idEvent = ''});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'descripcion': descripcion,
        'fecha': fecha,
        'direccion': direccion,
        'user_email': userEmail,
        'location': location,
        'numeroTelefono': numeroTelefono,
        'nombre': nombre,
        'idEvent': idEvent,
      };
  static EventDate fromJson(Map<String, dynamic> json) => EventDate(
      id: json['id'],
      title: json['title'],
      descripcion: json['descripcion'],
      fecha: (json['fecha'] as Timestamp).toDate(),
      direccion: json['direccion'],
      userEmail: json['user_email'],
      location: json['location'],
      numeroTelefono: json['numeroTelefono'],
      nombre: json['nombre'],
      idEvent: json['idEvent']);
      
}

//Clase que da modelo a la base de datos de lista de asistencia
class Attendance {
  late String id;
  String userEmail;
  int cantidadPersonas;
  String numeroTelefono;
  String nombre;

  Attendance(
      {this.id = '',
      required this.cantidadPersonas,
      required this.userEmail,
      required this.numeroTelefono,
      required this.nombre});
  Map<String, dynamic> toJson() => {
        'id': id,
        'countPersons': cantidadPersonas,
        'user_email': userEmail,
        'name': nombre,
        'numeroTelefono': numeroTelefono,
      };
  static Attendance fromJson(Map<String, dynamic> json) => Attendance(
        id: json['id'],
        cantidadPersonas: json['countPersons'],
        userEmail: json['user_email'],
        nombre: json['name'],
        numeroTelefono: json['numeroTelefono'],
      );
}

class AttendanceUserProfile {
  late String id;
  String idEvent;
  String userEmail;
  int cantidadPersonas;
  String nombre;
  String title;

  AttendanceUserProfile(
      {this.id = '',
      required this.idEvent,
      required this.title,
      required this.cantidadPersonas,
      required this.userEmail,
      required this.nombre});
  Map<String, dynamic> toJson() => {
        'id': id,
        'idEvent': idEvent,
        'title': title,
        'countPersons': cantidadPersonas,
        'user_email': userEmail,
        'name': nombre
      };
  static AttendanceUserProfile fromJson(Map<String, dynamic> json) =>
      AttendanceUserProfile(
        id: json['id'],
        idEvent: json['idEvent'],
        title: json['title'],
        cantidadPersonas: json['countPersons'],
        userEmail: json['user_email'],
        nombre: json['name'],
      );
}

//Clase que da modelo a la base de datos para la informacion de los usuarios registrados
class Users {
  late String id;
  String nombre;
  String direccionResidencia;
  String email;
  String numeroTelefono;
  int edad;
  String ubicacionImg;

  Users(
      {this.id = '',
      this.ubicacionImg = '',
      required this.nombre,
      required this.direccionResidencia,
      required this.email,
      required this.numeroTelefono,
      required this.edad});
  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'ubicacionImg': ubicacionImg,
        'direccionResidencia': direccionResidencia,
        'email': email,
        'numeroTelefono': numeroTelefono,
        'edad': edad,
      };
  static Users fromJson(Map<String, dynamic> json) => Users(
      id: json['id'],
      nombre: json['nombre'],
      direccionResidencia: json['direccionResidencia'],
      email: json['email'],
      edad: json['edad'],
      numeroTelefono: json['numeroTelefono'],
      ubicacionImg: json['ubicacionImg']);
}

class UsersProviders {
  late String id;
  String nombre;
  String nombreNegocio;
  String direccionResidencia;
  String email;
  String numeroTelefono;
  String rfc;
  int edad;
  String ubicacionImg;

  UsersProviders(
      {this.id = '',
      this.ubicacionImg = '',
      required this.rfc,
      required this.nombre,
      required this.nombreNegocio,
      required this.direccionResidencia,
      required this.email,
      required this.numeroTelefono,
      required this.edad});
  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'nombreNegocio': nombreNegocio,
        'ubicacionImg': ubicacionImg,
        'direccionResidencia': direccionResidencia,
        'email': email,
        'numeroTelefono': numeroTelefono,
        'edad': edad,
        'rfc': rfc,
      };
  static UsersProviders fromJson(Map<String, dynamic> json) => UsersProviders(
      id: json['id'],
      nombre: json['nombre'],
      nombreNegocio: json['nombreNegocio'],
      direccionResidencia: json['direccionResidencia'],
      email: json['email'],
      edad: json['edad'],
      numeroTelefono: json['numeroTelefono'],
      rfc: json['rfc'],
      ubicacionImg: json['ubicacionImg']);
}
