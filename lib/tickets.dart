import 'package:flutter/material.dart';

class Tickets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Tickets();
  }
}

class _Tickets extends State<Tickets> {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Material(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Color(color1),
                        size: (MediaQuery.of(context).size.width / 100) * 20,
                      ),
                    ),
                  ),
                  
                ],
              ),
              Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        heading,
                        style: TextStyle(
                          color: Color(color1),
                          fontFamily: 'Dosis',
                          fontSize:
                              (MediaQuery.of(context).size.width / 100) * 5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
      ),
      body: ListView(
        children: [
          SizedBox(height: (MediaQuery.of(context).size.height/100)*5,),
          myItems(Icons.confirmation_num, 'banque', 0xffF0F8FF, 0xff0000FF, '/bank/tickets'),
          SizedBox(height: (MediaQuery.of(context).size.height/100)*5,),
          myItems(Icons.nightlife_outlined, 'Evénement', 0xffF0F8FF, 0xff0000FF, '/bank/tickets'),
          SizedBox(height: (MediaQuery.of(context).size.height/100)*5,),
          myItems(Icons.train_outlined, 'Transport', 0xffF0F8FF, 0xff0000FF, '/bank/tickets'),
        ],
      ),
    );
  }
}
