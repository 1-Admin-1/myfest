import 'package:flutter/material.dart';
///Clase CountController
///Hace el control del contador de asistentes del eventos
///
class CountController extends StatefulWidget {
  //Datos necesario para mandar a llamar la clase
  const CountController({
    Key? key,
    required this.decrementIconBuilder,
    required this.incrementIconBuilder,
    required this.countBuilder,
    required this.count,
    required this.updateCount,
    this.stepSize = 1,
    this.minimum,
    this.maximum,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 25.0),
  }) : super(key: key);

  final Widget Function(bool enabled) decrementIconBuilder;
  final Widget Function(bool enabled) incrementIconBuilder;
  final Widget Function(int count) countBuilder;
  final int count;
  final Function(int) updateCount;
  final int stepSize;
  final int? minimum;
  final int? maximum;
  final EdgeInsetsGeometry contentPadding;

  @override
  _CountControllerState createState() => _CountControllerState();
}

class _CountControllerState extends State<CountController> {
  int get count => widget.count;
  int? get minimum => widget.minimum;
  int? get maximum => widget.maximum;
  int get stepSize => widget.stepSize;

  bool get canDecrement => minimum == null || count - stepSize >= minimum!;
  bool get canIncrement => maximum == null || count + stepSize <= maximum!;
//Funcion de disminuir
  void _decrementCounter() {
    if (canDecrement) {
      setState(() => widget.updateCount(count - stepSize));
    }
  }
//Funcion de incrementar 
  void _incrementCounter() {
    if (canIncrement) {
      setState(() => widget.updateCount(count + stepSize));
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: widget.contentPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: _decrementCounter,
              child: widget.decrementIconBuilder(canDecrement),
            ),
            widget.countBuilder(count),
            InkWell(
              onTap: _incrementCounter,
              child: widget.incrementIconBuilder(canIncrement),
            ),
          ],
        ),
      );
}
