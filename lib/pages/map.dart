import 'package:MyFest/Utils.dart';
import 'package:MyFest/widgets/marker_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:location/location.dart' as lc;
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//Clase PageMap
class PageMap extends StatefulWidget {
  const PageMap({Key? key}) : super(key: key);

  @override
  _MapScreen createState() => _MapScreen();
}

const DEFAULT_LOCATION = LatLng(20.80906836751571, -102.77288092317399);

class _MapScreen extends State<PageMap> {
  final Map<String, Marker> _markers = {};
  MapType mapType = MapType.normal;
  late BitmapDescriptor icon;
  bool isShowInfo = false;
  late GoogleMapController controller;
  late LatLng latLngOnLongPress;
  late lc.Location location;
  bool myLocationEnabled = false;
  bool myLocationButtonEnabled = false;
  LatLng currentLocation = DEFAULT_LOCATION;
  Set<Marker> makers = <Marker>{};
  Set<Circle> circles = <Circle>{};

  // Future<void> _onMapCreated(GoogleMapController controller) async {
  //   final googleOffices = await locations.getGoogleOffices();
  //   setState(() {
  //     _markers.clear();
  //     for (final office in googleOffices.offices) {
  //       final marker = Marker(
  //         markerId: MarkerId(office.name),
  //         position: LatLng(office.lat, office.lng),
  //         infoWindow: InfoWindow(
  //           title: office.name,
  //           snippet: office.address,
  //         ),
  //       );
  //       _markers[office.name] = marker;
  //     }
  //   });
  // }


  //Crea estilo del mapa abase de Utils
  onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyle);
    this.controller = controller;
  }
  //Muestra en consola las coordenadas
  onTapMap(LatLng latLng) {
    print("onTapMap ${latLng}");
  }
  //Muetsra un pop up de coordenadas
  onLongTapMap(LatLng latLng) {
    latLngOnLongPress = latLng;
    showPopUpMenu();
  }

  showPopUpMenu() async {
    String? selected = await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(200, 200, 250, 250),
        items: [
          const PopupMenuItem(
            value: "Que hay",
            child: Text("Que hay aqui"),
          ),
          const PopupMenuItem(
            value: "ir",
            child: Text("ir a"),
          ),
        ],
        elevation: 8.0);
    if (selected != null) getValue(selected);
  }
  //obtener valor
  getValue(String value) {
    if (value == "Que hay") print("Ubicación $latLngOnLongPress");
  }
  //crear un cuadro de informacion de un pin
  createMarker() {
    makers.add(Marker(
      markerId: const MarkerId("MarkerCurrent"),
      position: currentLocation,
      icon: icon,
      onTap: () => setState(() {
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation, zoom: 16)));

        isShowInfo = !isShowInfo;
      }),
    ));
  }
  //circulo alrededor de la posicion(Aun no implementado por problemas de optimizacion)
  createCircle() {
    circles.add(Circle(
      circleId: const CircleId("circleMap"),
      center: currentLocation,
      onTap: onTapCircle,
      consumeTapEvents: false,
      fillColor: Colors.pinkAccent,
      radius: 1000,
      strokeColor: Colors.red,
      strokeWidth: 6,
      visible: true,
    ));
  }

  onTapCircle() {
    print("onTapCircle");
  }
//Inicializar estado
  @override
  void initState() {
    super.initState();
    getIcons();
    requestPerms();
  }
  //Obtener localizacion
  getLocation() async {
    var currentLocation = await location.getLocation();
    updateLocation(currentLocation);
  }
  //Actualiza localizacion
  updateLocation(currentLocation) {
    if (currentLocation != null) {
      print(
          "Ubicacion actual del usuario latitud${currentLocation.latitude} longitud${currentLocation.longitude}");
      setState(() {
        currentLocation = currentLocation;
        // createCircle();
        // controller.animateCamera(CameraUpdate.newCameraPosition(
        //   CameraPosition(
        //       target:
        //           LatLng(currentLocation.latitude, currentLocation.longitude),
        //       zoom: 16),
        // ));
        createMarker();
      });
      
    }
  }
  //Cambio en tiempo real de localizacion
  locationChanged() {
    location.onLocationChanged.listen((lc.LocationData cLoc) {
      updateLocation(cLoc);
    });
  }
  //Manda habilitar permisos de localizacion hacia al usuario
  requestPerms() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.location].request();
    var status = statuses[Permission.location];
    if (status == PermissionStatus.denied) {
      requestPerms();
    } else {
      enableGPS();
    }
  }
  //Habilitar GPS
  enableGPS() async {
    location = lc.Location();
    bool serviceStatusResult = await location.requestService();
    if (!serviceStatusResult) {
      enableGPS();
    } else {
      updateStatus();
      getLocation();
      locationChanged();
    }
  }
//Actualizar estado
  updateStatus() {
    setState(() {
      myLocationButtonEnabled = true;
      myLocationEnabled = true;
    });
  }
//Obtener icono para el pin en el mapa
  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        "assets/images/pinFest.png");
    setState(() {
      this.icon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Obtiene la api de google 
          //Mandando a llamar funciones para usabilidad especifica del mapa
          GoogleMap(
            compassEnabled: true,
            mapToolbarEnabled: false,
            trafficEnabled: false,
            buildingsEnabled: true,
            zoomControlsEnabled: false,

            // onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              bearing: 90,
              tilt: 45,
              zoom: 15,
            ),
            circles: circles,

            myLocationEnabled: myLocationEnabled,
            myLocationButtonEnabled: myLocationButtonEnabled,
            onCameraMoveStarted: () => {print("inicio")},
            onCameraIdle: () => {print("fin")},
            onCameraMove: (CameraPosition cameraPosition) =>
                {print("moviendo ${cameraPosition.target}")},
            onMapCreated: onMapCreated,
            mapType: mapType,
            onLongPress: onLongTapMap,
            onTap: onTapMap,

            minMaxZoomPreference: MinMaxZoomPreference(5, 25),
            markers: makers,
            // markers: ({
            //   Marker(
            //     markerId: MarkerId(currentLocation.toString()),
            //     position: currentLocation,
            //     icon: this.icon,
            //     onTap: () => setState(() {
            //       controller.animateCamera(CameraUpdate.newCameraPosition(
            //           CameraPosition(target: currentLocation, zoom: 16)));

            //       this.isShowInfo = !this.isShowInfo;
            //     }),
            //     // alpha: 1,
            //     // anchor: const Offset(0.2, 0.2),
            //     // draggable: true,
            //     // onDragEnd: onDragEnd,
            //     // zIndex: 1
            //   )
            // }),
          ),
          //Clase de visibilidad para el pin con datos especificos
          Visibility(
              visible: isShowInfo,
              child: MarkerInformation("Mi ubicacion", this.currentLocation,
                  "assets/images/playstore.png"))
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.black,
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        elevation: 8.0,
        children: [
          //Cambiar el diseno del mapa para preferencia del usuario
          SpeedDialChild(
              label: "NORMAL",
              child: Icon(Icons.room),
              onTap: () => setState(() => mapType = MapType.normal)),
          SpeedDialChild(
              label: "SATELITAL",
              child: Icon(Icons.satellite),
              onTap: () => setState(() => mapType = MapType.satellite)),
          SpeedDialChild(
              label: "HIBRIDO",
              child: Icon(Icons.compare),
              onTap: () => setState(() => mapType = MapType.hybrid)),
          SpeedDialChild(
              label: "TERRENO",
              child: Icon(Icons.terrain),
              onTap: () => setState(() => mapType = MapType.terrain))
        ],
      ),
    );
  }
  //Impresion en consola para verificar la nueva posicion
  onDragEnd(LatLng position) {
    print("new position $position");
  }
}
