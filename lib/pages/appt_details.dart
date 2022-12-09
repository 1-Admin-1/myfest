import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:MyFest/models/dataEvents.dart';
import 'package:MyFest/pages/admin_screen.dart';
import '../Main.dart';

class AppointmentDetails extends StatefulWidget {
  final Appointment appointment;
  const AppointmentDetails(this.appointment);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    void editAppointment(Appointment appt) {
      setState(() {
        widget.appointment.status = appt.status;
      });
    }

    log(widget.appointment.status);

    const txtHeader = Center(
        child: Text("Appointment Details", style: TextStyle(fontSize: 24.0)));

    final confirmBtn = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(15),
        color: widget.appointment.status == "confirmed"
            ? Colors.grey
            : Colors.red,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () => widget.appointment.status == "confirmed"
              ? null
              : null,
          child: const Text(
            "Confirm",
            style: TextStyle(color: Colors.white),
          ),
        ));

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          txtHeader,
          const SizedBox(height: 20.0),
          BuildRow(title: "Name", details: widget.appointment.name),
          BuildRow(title: "Service", details: widget.appointment.service),
          BuildRow(title: "Date", details: widget.appointment.time),
          BuildRow(
              title: "Time", details: "(widget.appointment.time)}"),
          BuildRow(title: "Status", details: widget.appointment.status),
          const SizedBox(height: 20.0),
          confirmBtn
        ]),
      ),
    );
  }
}


class BuildRow extends StatelessWidget {
  final title;
  final details;
  const BuildRow({this.title, this.details});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Text("$title:", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10.0),
          Text("$details"),
        ],
      ),
    );
  }
}
