
import 'package:MyFest/app_theme.dart';
import 'package:MyFest/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cart_bloc.dart';
import 'bloc/event/cart_event.dart';
import 'models/dataEvents.dart';
import 'widgets/count_controller.dart';

class ProductDetailWidget extends StatefulWidget {
  const ProductDetailWidget({Key? key, required this.events}) : super(key: key);

  final Events events;

  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int? countControllerValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String fechaaux = widget.events.fecha.toString();
    String fecha;
    
      fecha = fechaaux.replaceAll("00:00:00.000", "");
    
    return Scaffold(
      key: scaffoldKey,
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
          ' ${widget.events.title}',
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
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                    child: Hero(
                      tag: 'mainImage',
                      transitionOnUserGestures: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/logoNombre.png',
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Row(
                      children: [
                        const Text('Dirección: ',style: TextStyle(
                          color: Colors.white, 
                          fontFamily: 'Poppins' ,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                        Text(
                          widget.events.direccion,
                          style: AppTheme.of(context).title1,
                        ),
                        const Text('  Número: ',style: TextStyle(
                          color: Colors.white, 
                          fontFamily: 'Poppins' ,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                        Text(
                          widget.events.numeroDireccion.toString(),
                          style: AppTheme.of(context).title1,
                        ),
                      ],)
                    
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Row(
                      children: [
                        const Text('Fecha: ',style: TextStyle(
                          color: Colors.white, 
                          fontFamily: 'Poppins' ,
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
                      widget.events.descripcion,
                      style: AppTheme.of(context).bodyText5,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                      child: CountController(
                        decrementIconBuilder: (enabled) => Icon(
                          Icons.remove_rounded,
                          color: enabled
                              ? AppTheme.of(context).secondaryText
                              : AppTheme.of(context).secondaryText,
                          size: 25,
                        ),
                        contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
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
                        updateCount: (count) =>
                            setState(() => countControllerValue = count),
                        stepSize: 1,
                        minimum: 1,
                      ),
                    ),
                    
                    MyButtonWidget(
                      onPressed: () {
                        Product p = widget.events as Product;
                        p.quantity = countControllerValue!.toInt();
                        // BlocProvider.of<CartBloc>(context).add(AddProduct(p));
                      },
                      text: 'ASISTIR',
                      options: ButtonOptions(
                          width: 140,
                          height: 50,
                          color: const Color(0xfff70506),
                          textStyle: AppTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                          elevation: 5,
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(36))),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
