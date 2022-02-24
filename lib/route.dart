

import 'package:flutter/material.dart';

//pages
import 'package:eticket/bottomnav.dart';
import 'package:eticket/bank/listBank.dart';
import 'package:eticket/bank/formBank.dart';
import 'package:eticket/bank/previewTicket.dart';
import 'package:eticket/bank/tickets.dart';

class Routes {
  var routes = <String, WidgetBuilder>{
    "/bottomnav": (BuildContext context) => new BottomNav(),
    "/bank/listBank": (BuildContext context) => new ListBank(),
    "/bank/formBank": (BuildContext context) => new FormBank(),
    "/bank/viewTicket": (BuildContext context) => new PreviewTicket(),
    "/bank/tickets": (BuildContext context) => new Tickets(),
    "/event": (BuildContext context) => new BottomNav(),
    "/trans": (BuildContext context) => new BottomNav(),
  };

  Routes() {
    runApp(new MaterialApp(
      title: 'Eticket',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: new BottomNav(),
      routes: routes,
    ));
  }
}
