import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;

  Lesson(
      {required this.title,
      required this.level,
      required this.indicatorValue,
      required this.price,
      required this.content});
}

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

class Events {
  late String id;
  String title;
  String descripcion;
  DateTime fecha;
  String direccion;
  int numeroDireccion;
  String userEmail;

  Events(
      {this.id = '',
      required this.title,
      required this.descripcion,
      required this.fecha,
      required this.direccion,
      required this.numeroDireccion,
      required this.userEmail});
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'descripcion': descripcion,
        'fecha': fecha,
        'direccion': direccion,
        'numeroDireccion': numeroDireccion,
        'user_email': userEmail,
      };
  static Events fromJson(Map<String, dynamic> json) => Events(
        id: json['id'],
        title: json['title'],
        descripcion: json['descripcion'],
        fecha: (json['fecha'] as Timestamp).toDate(),
        direccion: json['direccion'],
        numeroDireccion: json['numeroDireccion'],
        userEmail: json['user_email'],
      );
}

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
      this.ubicacionImg='',
      required this.nombre,
      required this.direccionResidencia,
      required this.email,
      required this.numeroTelefono,
      required this.edad});
  Map<String, dynamic> toJson() => {
      'id': id,
      'nombre': nombre,
      'ubicacionImg': ubicacionImg,
      'direccionResidencia':direccionResidencia,
      'email':email,
      'numeroTelefono':numeroTelefono,
      'edad': edad,
      };
  static Users fromJson(Map<String, dynamic> json) => Users(
        id: json['id'],
        nombre: json['nombre'],
        direccionResidencia: json['direccionResidencia'],
        email: json['email'],
        edad: json['edad'],
        numeroTelefono: json['numeroTelefono'],
        ubicacionImg: json['ubicacionImg']
      );
}



class Appointment {
  final String name;
  final DateTime time;
  final String service;
  String status;
  final String? id;

  Appointment(
      {required this.name, required this.time, required this.service, required this.status, this.id});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        name: json['name'],
        time: (json['time']).toDate(),
        service: json['service'],
        status: json['status'],
        id: json['id']);
  }
  
  toJson() {
    return {
      'name': name,
      'service': service,
      'time': Timestamp.fromDate(time),
      'status': status,
      'id': id
    };
  }
}
