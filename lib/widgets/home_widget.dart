
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:drag_and_drop_gridview/devdrag.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_circular_chart/flutter_circular_chart.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// //Clase que da vista al home
// //Aun no esta implementado las funciones solo es diseño preeliminar
// class GridDashboard extends StatelessWidget {
//   Items item1 = Items(
//       title: "Calendario",
//       subtitle: "Marzo 2022",
//       event: "50 Eventos",
//       img: "assets/images/calendar.png");

//   Items item2 = Items(
//     title: "Terrazas",
//     subtitle: "",
//     event: "Lista de Terrazas",
//     img: "assets/images/setting.png",
//   );
//   Items item3 = Items(
//     title: "Puntos de Venta",
//     subtitle: "Tiendas",
//     event: "",
//     img: "assets/images/map.png",
//   );
//   Items item4 = Items(
//     title: "Promociones",
//     subtitle: "Rose favirited your Post",
//     event: "",
//     img: "assets/images/setting.png",
//   );
//   Items item5 = Items(
//     title: "Perfil",
//     subtitle: "Datos de Usuario",
//     event: "",
//     img: "assets/images/usuario.png",
//   );
//   Items item6 = Items(
//     title: "Configuración",
//     subtitle: "",
//     event: "",
//     img: "assets/images/setting.png",
//   );
  

//   Material myTextItems(String title, String subtitle){
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       borderRadius: BorderRadius.circular(24.0),
//       shadowColor: Color(0x802196F3),
//       child: Center(
//         child:Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment:MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment:MainAxisAlignment.center,
//                children: <Widget>[

//                   Padding(
//                    padding: EdgeInsets.all(8.0),
//                       child:Text(title,style:TextStyle(
//                         fontSize: 20.0,
//                         color: Colors.blueAccent,
//                       ),),
//                     ),

//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child:Text(subtitle,style:TextStyle(
//                       fontSize: 30.0,
//                     ),),
//                   ),

//                ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }


//   Material myCircularItems(String title, String subtitle){
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       borderRadius: BorderRadius.circular(24.0),
//       shadowColor: Color(0x802196F3),
//       child: Center(
//         child:Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment:MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment:MainAxisAlignment.center,
//                 children: <Widget>[

//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child:Text(title,style:TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.blueAccent,
//                     ),),
//                   ),

//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child:Text(subtitle,style:TextStyle(
//                       fontSize: 30.0,
//                     ),),
//                   ),

//                   Padding(
//                     padding:EdgeInsets.all(8.0),
//                     child:AnimatedCircularChart(
//                       size: const Size(100.0, 100.0),
//                       initialChartData: circularData,
//                       chartType: CircularChartType.Pie,
//                     ),
//                   ),

//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }


//   Material mychart1Items(String title, String priceVal,String subtitle) {
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       borderRadius: BorderRadius.circular(24.0),
//       shadowColor: Color(0x802196F3),
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[

//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(title, style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.blueAccent,
//                     ),),
//                   ),

//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(priceVal, style: TextStyle(
//                       fontSize: 30.0,
//                     ),),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(subtitle, style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.blueGrey,
//                     ),),
//                   ),

//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: new Sparkline(
//                       data: data,
//                       lineColor: Color(0xffff6101),
//                       pointsMode: PointsMode.all,
//                       pointSize: 8.0,
//                     ),
//                   ),

//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }


//   Material mychart2Items(String title, String priceVal,String subtitle) {
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       borderRadius: BorderRadius.circular(24.0),
//       shadowColor: Color(0x802196F3),
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[

//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(title, style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.blueAccent,
//                     ),),
//                   ),

//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(priceVal, style: TextStyle(
//                       fontSize: 30.0,
//                     ),),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(subtitle, style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.blueGrey,
//                     ),),
//                   ),

//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     // ignore: unnecessary_new
//                     child: new Sparkline(
//                       data: data1,
//                       fillMode: FillMode.below,
//                       fillGradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: Colors.accents,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(icon: Icon(Icons.menu), onPressed: () {
//           //
//         }),
//         title: Text('Hola'),
//         actions: <Widget>[
//           IconButton(icon: Icon(
//               FontAwesomeIcons.chartLine), onPressed: () {
//             //
//           }),
//         ],
//       ),
//       body:Container(
//           color:Color(0xffE5E5E5),
//           child:StaggeredGrid.count(
//             crossAxisCount: 4,
//            crossAxisSpacing: 12.0,
//           mainAxisSpacing: 12.0,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: mychart1Items("Sales by Month","421.3M","+12.9% of target"),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: myCircularItems("Quarterly Profits","68.7M"),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right:8.0),
//             child: myTextItems("Mktg. Spend","48.6M"),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right:8.0),
//             child: myTextItems("Users","25.5M"),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: mychart2Items("Conversion","0.9M","+19% of target"),
//           ),
//       StaggeredGrid.extent(maxCrossAxisExtent: 4, crossAxisSpacing: 250),
//           StaggeredGrid.extent(maxCrossAxisExtent: 2, crossAxisSpacing: 250),
//           StaggeredGrid.extent(maxCrossAxisExtent: 2, crossAxisSpacing: 120),
//           StaggeredGrid.extent(maxCrossAxisExtent: 2, crossAxisSpacing: 120),
//           StaggeredGrid.extent(maxCrossAxisExtent: 4, crossAxisSpacing: 250),
//         ],
        
          
        
//       ),
//       ),
//     );
//     // List<Items> myList = [item1, item2, item3, item4, item5, item6];
//     // var color = 0xff453658;
//     // return Flexible(
//     //   child: GridView.count(
//     //       childAspectRatio: 1.0,
//     //       padding: const EdgeInsets.only(left: 16, right: 16),
//     //       crossAxisCount: 2,
//     //       crossAxisSpacing: 18,
//     //       mainAxisSpacing: 18,
//     //       children: myList.map((data) {
//     //         return Container(
//     //           decoration: BoxDecoration(
//     //               color: Color(color), borderRadius: BorderRadius.circular(10)),
//     //           child: Column(
//     //             mainAxisAlignment: MainAxisAlignment.center,
//     //             children: <Widget>[
//     //               Image.asset(
//     //                 data.img,
//     //                 width: 42,
//     //               ),
//     //               const SizedBox(
//     //                 height: 14,
//     //               ),
//     //               Text(
//     //                 data.title,
//     //                 style: GoogleFonts.openSans(
//     //                     textStyle: const TextStyle(
//     //                         color: Colors.white,
//     //                         fontSize: 16,
//     //                         fontWeight: FontWeight.w600)),
//     //               ),
//     //               const SizedBox(
//     //                 height: 8,
//     //               ),
//     //               Text(
//     //                 data.subtitle,
//     //                 style: GoogleFonts.openSans(
//     //                     textStyle: const TextStyle(
//     //                         color: Colors.white38,
//     //                         fontSize: 10,
//     //                         fontWeight: FontWeight.w600)),
//     //               ),
//     //               const SizedBox(
//     //                 height: 14,
//     //               ),
//     //               Text(
//     //                 data.event,
//     //                 style: GoogleFonts.openSans(
//     //                     textStyle: const TextStyle(
//     //                         color: Colors.white70,
//     //                         fontSize: 11,
//     //                         fontWeight: FontWeight.w600)),
//     //               ),
//     //             ],
//     //           ),
//     //         );
//     //       }).toList()),
//     // );
//   }
// }

// // class Items {
// //   String title;
// //   String subtitle;
// //   String event;
// //   String img;
// //   Items({required this.title, required this.subtitle, required this.event, required this.img});
// // }
