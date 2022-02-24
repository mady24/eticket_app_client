import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eticket/class/Ticket.dart';

class Tickets extends StatefulWidget {
  @override
  _Tickets createState() => _Tickets();
}

class _Tickets extends State<Tickets> {
  List<Ticket> _ticket = [];
  Future<void> fetchTicket() async {
    final response = await http
        .get(Uri.parse('http://api.eticket.sn/index.php/showTicketsByUser/1'));
    var data1 = response.body;
    var data = jsonDecode(response.body)['data'] as List;
    setState(() {
      _ticket = data.map((TicketJson) => Ticket.fromJson(TicketJson)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTicket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tickets'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: (MediaQuery.of(context).size.height/100)*3,),
            Container(height: (MediaQuery.of(context).size.height/100)*85,
            child: Padding(padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: _ticket.length,
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Material(
                  color: Colors.white,
                  elevation: 7.0,
                  shadowColor: Color(0x802196F3),
                  borderRadius: BorderRadius.circular(24.0),
                  child: GestureDetector(
                      onTap: () => {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.network(
                                  'http://admin.eticket.sn/img/'+_ticket[position].ImageBank,
                                  height: (MediaQuery.of(context).size.width/100)*10,
                                  width: (MediaQuery.of(context).size.width/100)*10,
                                  ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "${_ticket[position].NomBank}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Cambria',
                                    fontSize: (MediaQuery.of(context).size.width/100)*5),
                              ),
                            ),
                              ]
                            ),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width :(MediaQuery.of(context).size.width/100)*45,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                    Icon(
                                      Icons.gps_fixed,
                                      size: (MediaQuery.of(context).size.width/100)*5,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          '${_ticket[position].NomRegion}',
                                          style: TextStyle(
                                              fontFamily: 'Cambria',
                                              fontSize: (MediaQuery.of(context).size.width/100)*5),
                                        ))
                                      ]
                                    ),
                                    Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                    Icon(
                                      Icons.location_city,
                                      size: (MediaQuery.of(context).size.width/100)*5,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          '${_ticket[position].NomAgence}',
                                          style: TextStyle(
                                              fontFamily: 'Cambria',
                                              fontSize: (MediaQuery.of(context).size.width/100)*5),
                                        ))
                                      ]
                                    ),
                                    Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                    Icon(
                                      Icons.calendar_today,
                                      size: (MediaQuery.of(context).size.width/100)*5,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          '${_ticket[position].DateTicket.substring(0,10)}',
                                          style: TextStyle(
                                              fontFamily: 'Cambria',
                                              fontSize: (MediaQuery.of(context).size.width/100)*5),
                                        ))
                                      ]
                                    ),
                                  ],
                                ),
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.width/100)*10,
                              width: 2.0,
                              child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black))),
                            ),
                                Container(
                                  width :(MediaQuery.of(context).size.width/100)*45,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          '${_ticket[position].numero}',
                                          style: TextStyle(
                                              fontFamily: 'Cambria',
                                              fontSize: (MediaQuery.of(context).size.width/100)*5),
                                          textAlign: TextAlign.right,
                                        )),
                                        Icon(
                                      Icons.flag,
                                      size: (MediaQuery.of(context).size.width/100)*5
                                    ),
                                      ]
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          '${_ticket[position].count}',
                                          style: TextStyle(
                                              fontFamily: 'Cambria',
                                              fontSize: (MediaQuery.of(context).size.width/100)*5),
                                          textAlign: TextAlign.right,
                                        )),
                                        Icon(
                                      Icons.last_page,
                                      size: (MediaQuery.of(context).size.width/100)*5
                                    ),
                                      ]
                                    ),
                                    ElevatedButton(onPressed: ()=>{}, child: Text('Je serais en retard!',
                                          style: TextStyle(
                                              fontFamily: 'Cambria',
                                              fontSize: (MediaQuery.of(context).size.width/100)*3),
                                          textAlign: TextAlign.center,))
                                  ],
                                )
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              );
            })
            )
            ),
          ]
        )
            );
  }
}
