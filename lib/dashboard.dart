import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  Material myItems(
      IconData icon, String heading, int color, int color1, String page) {
    return Material(
      color: Color(color),
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: GestureDetector(
        onTap: () => onPressed(page),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Color(color1),
                        size: (MediaQuery.of(context).size.width/100)*20,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        heading,
                        style: TextStyle(
                          color: Color(color1),
                          fontFamily: 'Dosis',
                          fontSize: (MediaQuery.of(context).size.width/100)*5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: (MediaQuery.of(context).size.height/100)*5,),
              Container(
                color: Colors.white,
                constraints: BoxConstraints(
                  maxHeight: (MediaQuery.of(context).size.height/100)*85,
                  minHeight: (MediaQuery.of(context).size.height/100)*85,
                ),
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(width: (MediaQuery.of(context).size.width/100)*5),
                        Container(
                          width: (MediaQuery.of(context).size.width/100)*42,
                          height: (MediaQuery.of(context).size.height/100)*30,
                          child: myItems(Icons.business_outlined, "Banque", 0xffF0F8FF, 0xff000000, "/bank/listBank"),
                        ),
                        SizedBox(width: (MediaQuery.of(context).size.width/100)*5),
                        Container(
                          width: (MediaQuery.of(context).size.width/100)*42,
                          height: (MediaQuery.of(context).size.height/100)*30,
                          child: myItems(Icons.nightlife_outlined, "Evenement", 0xffF0F8FF, 0xff000000, "/event"),
                        ),
                        SizedBox(width: (MediaQuery.of(context).size.width/100)*5),
                      ],
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height/100)*2),
                    Row(
                      children: <Widget>[
                        SizedBox(width: (MediaQuery.of(context).size.width/100)*5),
                        Container(
                          width: (MediaQuery.of(context).size.width/100)*42,
                          height: (MediaQuery.of(context).size.height/100)*30,
                          child: myItems(Icons.train_outlined, "Transport", 0xffF0F8FF, 0xff000000, "/trans"),
                        ),
                        SizedBox(width: (MediaQuery.of(context).size.width/100)*5),
                        /*Container(
                          width: (MediaQuery.of(context).size.width/100)*42,
                          height: (MediaQuery.of(context).size.height/100)*30,
                          child: myItems(Icons.nightlife_outlined, "Evenement", 0xffF0F8FF, 0xff000000, "/bank"),
                        ),*/
                        SizedBox(width: (MediaQuery.of(context).size.width/100)*5),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
    );
  }
}
