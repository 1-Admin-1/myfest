import 'models/dataEvents.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  
  final Events events;
  const DetailPage({Key? key, required this.events}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    

    // final coursePrice = Container(
    //   padding: const EdgeInsets.all(7.0),
    //   decoration: new BoxDecoration(
    //       border: new Border.all(color: Colors.white),
    //       borderRadius: BorderRadius.circular(5.0)),
    //   child: new Text(
    //     "\$" + lesson.price.toString(),
    //     style: TextStyle(color: Colors.white),
    //   ),
    // );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 90.0),
        Icon(
          Icons.directions_car,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Color(0xfff70506)),
        ),
        SizedBox(height: 10.0),
        Text(
          events.title,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(right: 50.0,left: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                     
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 25),
                            text: 'Fecha  ',
                            children: <TextSpan>[
                              TextSpan(text: events.fecha.day.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                              const TextSpan(text: '-',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                              TextSpan(text: events.fecha.month.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                              const TextSpan(text: '-',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                              TextSpan(text: events.fecha.year.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                              
                            ],
                          ),
                        ),
                      ],
                      ),
                      
                  
                    
                    )),
            
          ],
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(right: 50.0,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                     
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 25),
                            text: 'Dirección  ',
                            children: <TextSpan>[
                              TextSpan(text: events.direccion, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                             
                            ],
                          ),
                        ),
                      ],
                      ),
                      
                  
                    
                    )),
            
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("drive-steering-wheel.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      events.descripcion,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {},
        child: Text("Asistir", style: TextStyle(color: Colors.white)),
      ),
    );
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
