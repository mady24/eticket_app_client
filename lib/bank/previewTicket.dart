import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eticket/class/Args.dart';
import 'package:eticket/class/Agence.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../class/Region.dart';

class PreviewTicket extends StatefulWidget {
  @override
  _PreviewTicket createState() => _PreviewTicket();
}

class _PreviewTicket extends State<PreviewTicket> {
  var idBank1,
      imageBank,
      nomBank,
      idAgence,
      idRegion,
      idService,
      date,
      textRegion,
      textAgence,
      arguments,
      resp;
  List<Agence> _agence = [];
  List<Region> _region = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  fetchAgence() async {
    final SharedPreferences prefs = await _prefs;
    var idAgence = prefs.getInt('idAgence');
    final response = await http.get(
        Uri.parse('http://api.eticket.sn/index.php/showAgenceByID/$idAgence'));
    log('http://api.eticket.sn/index.php/showAgenceByID/$idAgence');
    var data1 = response.body;
    log(data1);
    var data = jsonDecode(response.body)['data'] as List;
    setState(() {
      _agence = data.map((AgenceJson) => Agence.fromJson(AgenceJson)).toList();
      textAgence = _agence[0].NomAgence;
    });
  }

  fetchRegion() async {
    final SharedPreferences prefs = await _prefs;
    var idRegion = prefs.getInt('idRegion');
    final response = await http.get(
        Uri.parse('http://api.eticket.sn/index.php/showRegionByID/$idRegion'));
    log('http://api.eticket.sn/index.php/showRegionByID/$idRegion');
    var data1 = response.body;
    log(data1);
    var data = jsonDecode(response.body)['data'] as List;
    setState(() {
      _region = data.map((RegionJson) => Region.fromJson(RegionJson)).toList();
      textRegion = _region[0].NomRegion;
    });
  }

  Future<void> addTicket(Args data) async {
    final String data1 =
        '{"IDAgence":"${data.idAgence}","IDUser":"1","dateT":"${data.date}","timeT":"00:00:00"}';
    final response = await http
        .get(Uri.parse('http://api.eticket.sn/index.php/addTicket/$data1'));
    var data2 = response.body;
    log('$data2');
    setState(() {
      resp = jsonDecode(response.body)['status'];
      log('$resp');
    });
    
  }

  onPressed(Args data) {
    addTicket(data);
    //if (resp == 200) {
      Navigator.of(context).pushNamed('/bank/tickets');
    //}
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      Future.delayed(Duration.zero, () {
        arguments = ModalRoute.of(context)?.settings.arguments as Args;
        idRegion = arguments.idRegion;
        idAgence = arguments.idAgence;
        log('$arguments');
      });
    });
    fetchRegion();
    fetchAgence();
    new Future.delayed(const Duration(seconds: 5));
    log('region: $_region');
    log('agence: $_agence');
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Args;
    idBank1 = arguments.id;
    nomBank = arguments.nom;
    imageBank = arguments.image;
    idAgence = arguments.idAgence;
    idRegion = arguments.idRegion;
    idService = arguments.idService;
    date = arguments.date;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Reserver un Ticket'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 120.0,
                  vertical: 20.0,
                ),
                child: Image.network(
                  'http://admin.eticket.sn/img/$imageBank',
                  height: 120.0,
                  width: 120.0,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Text(
                    '$nomBank',
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black,
                )),
                height: 2.0,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: (MediaQuery.of(context).size.width / 100) * 45,
                    height: (MediaQuery.of(context).size.height / 100) * 10,
                    decoration: BoxDecoration(),
                    child: Text(
                      'Région :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (MediaQuery.of(context).size.width / 100) * 3,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Container(
                    width: (MediaQuery.of(context).size.width / 100) * 45,
                    height: (MediaQuery.of(context).size.height / 100) * 10,
                    child: Text(
                      '$textRegion',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (MediaQuery.of(context).size.width / 100) * 3,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: (MediaQuery.of(context).size.width / 100) * 45,
                    height: (MediaQuery.of(context).size.height / 100) * 10,
                    decoration: BoxDecoration(),
                    child: Text(
                      'Agence :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (MediaQuery.of(context).size.width / 100) * 3,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Container(
                    width: (MediaQuery.of(context).size.width / 100) * 45,
                    height: (MediaQuery.of(context).size.height / 100) * 10,
                    decoration: BoxDecoration(),
                    child: Text(
                      '$textAgence',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (MediaQuery.of(context).size.width / 100) * 3,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: (MediaQuery.of(context).size.width / 100) * 45,
                    height: (MediaQuery.of(context).size.height / 100) * 10,
                    decoration: BoxDecoration(),
                    child: Text(
                      'Date :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (MediaQuery.of(context).size.width / 100) * 3,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Container(
                    width: (MediaQuery.of(context).size.width / 100) * 45,
                    height: (MediaQuery.of(context).size.height / 100) * 10,
                    decoration: BoxDecoration(),
                    child: Text(
                      '${DateFormat('dd/MM/yyyy').format(date)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (MediaQuery.of(context).size.width / 100) * 3,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: (MediaQuery.of(context).size.width / 100) * 45,
                    height: (MediaQuery.of(context).size.height / 100) * 10,
                    decoration: BoxDecoration(),
                    child: Text(
                      'Service :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (MediaQuery.of(context).size.width / 100) * 3,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Container(
                    width: (MediaQuery.of(context).size.width / 100) * 45,
                    height: (MediaQuery.of(context).size.height / 100) * 10,
                    decoration: BoxDecoration(),
                    child: Text(
                      'Caisse',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (MediaQuery.of(context).size.width / 100) * 3,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
              ],
            ),
            ElevatedButton(
                onPressed: () => onPressed(arguments),
                child: Text(
                  'Confirmer',
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width / 100) * 3,
                  ),
                ))
          ],
        ));
  }
}
