import 'package:MyFest/db/locations.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MarkerInformation extends StatefulWidget {
  String title;
  LatLng latLng;
  String image;
  // ignore: use_key_in_widget_constructors
  MarkerInformation(this.title, this.latLng, this.image);
  @override
  State<StatefulWidget> createState() => MarkerInformationState();
}

class MarkerInformationState extends State<MarkerInformation> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
      height: 70,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.black),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10),
          width: 50,
          height: 50,
          child: ClipOval(
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40),
          child: Column(children: <Widget>[
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Latitud: ${widget.latLng.latitude}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.redAccent),
            ),
            Text(
              "Longitud: ${widget.latLng.longitude}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.redAccent),
            ),
          ]),
        )
      ]),
    );
  }
}
