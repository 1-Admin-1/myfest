import 'package:MyFest/main.dart';
import 'package:flutter/material.dart';
import 'package:MyFest/appt_model.dart';
import 'package:MyFest/pages/admin_screen.dart';
import 'package:MyFest/pages/appt_details.dart';
import 'package:MyFest/pages/login_page.dart';
import 'package:MyFest/pages/user_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/user':
        return MaterialPageRoute(builder: (_) => const UserHomePage(), settings: settings);
      case '/admin':
        return MaterialPageRoute(builder: (_) => const AdminHomePage(), settings: settings);
      case '/details':
        return MaterialPageRoute(builder: (_) => AppointmentDetails(args as Appointment));
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
