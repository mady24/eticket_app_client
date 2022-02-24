import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:eticket/class/Agence.dart';
import 'package:eticket/class/Region.dart';
import 'package:flutter/material.dart';
import 'package:eticket/class/Args.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../class/Bank.dart';

class FormBank extends StatefulWidget {
  @override
  _FormBank createState() => _FormBank();
}

class _FormBank extends State<FormBank> {
  var idBank1, nomBank, imageBank;
  List<Region> _region = [];
  List<DropdownMenuItem<int>> menuitems = [];
  int selectedRegion = 0;
  List<Agence> _agence = [];
  int selectedAgence = 0;
  int selectedService = 1;
  bool disabledropdown = true;
  int value = 0;
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> fetchRegion() async {
    final response =
        await http.get(Uri.parse('http://api.eticket.sn/index.php/showRegion'));
    var data1 = response.body;
    //log(data1);
    var data = jsonDecode(response.body)['data'] as List;
    setState(() {
      _region = data.map((RegionJson) => Region.fromJson(RegionJson)).toList();
      selectedRegion = _region[0].IDRegion;
    });
  }

  void secondselected(_value) {
    setState(() {
      selectedAgence = _value;
    });
  }

  Future<void> fetchAgence(idBank, idRegion) async {
    final response = await http.get(Uri.parse(
        'http://api.eticket.sn/index.php/showAgenceByBankRegion/$idBank/$idRegion'));
    //log('http://api.eticket.sn/index.php/showAgenceByBankRegion/$idBank/$idRegion');
    var data1 = response.body;
    //log(data1);
    var data = jsonDecode(response.body)['data'] as List;
    setState(() {
      _agence = data.map((AgenceJson) => Agence.fromJson(AgenceJson)).toList();
      selectedAgence = _agence[0].IDAgence;
    });
  }

  onPressed(String routeName, idBank, nomBank, imageBank, idAgence, idRegion,
      idService, date) {
    Args args =
        Args(idBank, nomBank, imageBank, idAgence, idRegion, idService, date);
    saveInt('idRegion', idRegion);
    saveInt('idAgence', idAgence);
    Navigator.of(context).pushNamed(routeName, arguments: args);
  }
 saveInt(cle, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //final scanned = 42;
    prefs.setInt(cle, value);
    print('saved $cle $value');
  }
  saveString(cle, value) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    //final scanned = 42;
    prefs.setString(cle, value);
    print('saved $cle $value');
  }
  @override
  void initState() {
    super.initState();
    fetchRegion();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Args;
    if (arguments.id != null) {
      idBank1 = arguments.id;
      nomBank = arguments.nom;
      imageBank = arguments.image;
      ////log('$arg');
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Reserver un Ticket'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 120.0, vertical: 20.0),
                  child: Image.network(
                    'http://admin.eticket.sn/img/$imageBank',
                    height: 120.0,
                    width: 120.0,
                  ),
                ),
              ),
            ),
            Container(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Text(
                      "$nomBank",
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black, )), height: 2.0,),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Text(
                  'Région',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: (MediaQuery.of(context).size.width/100)*3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 100) * 90,
                  height: (MediaQuery.of(context).size.height / 100) * 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                    child: DropdownButton<int>(
                      isExpanded: true,
                      isDense: false,
                      hint: Text('Choisissez votre région'),
                      value: selectedRegion,
                      onChanged: (_value) {
                        setState(() {
                          //log('$_value');
                          selectedRegion = _value!;
                          //log('$selectedRegion');
                          disabledropdown = false;
                          fetchAgence(arguments.id, selectedRegion);
                        });
                      },
                      items: _region.map((Region map) {
                        return DropdownMenuItem(
                          value: map.IDRegion,
                          child: Text(
                            map.NomRegion,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: (MediaQuery.of(context).size.width/100)*3
                              ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Text(
                  'Agence',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: (MediaQuery.of(context).size.width/100)*3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 100) * 90,
                  height: (MediaQuery.of(context).size.height / 100) * 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                    child: DropdownButton(
                      isExpanded: true,
                      isDense: false,
                      value: selectedAgence,
                      onChanged: disabledropdown
                          ? null
                          : (_value) => secondselected(_value),
                      hint: Text('Choisissez votre agence'),
                      disabledHint: Text("Choisissez d'abord une région!"),
                      items: _agence.map((Agence map) {
                        return DropdownMenuItem(
                          value: map.IDAgence,
                          child: Text(
                            map.NomAgence,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: (MediaQuery.of(context).size.width/100)*3
                              ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Text(
                  'Date',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: (MediaQuery.of(context).size.width/100)*3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 100) * 2,
                ),
                Row(children: <Widget>[
                  Text("${selectedDate.toLocal()}".split(' ')[0],style: TextStyle(fontSize: (MediaQuery.of(context).size.width/100)*3),),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 100) * 10,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Selectionnez la date',style: TextStyle(fontSize: (MediaQuery.of(context).size.width/100)*3),),
                  ),
                ])
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Text(
                  'Service',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: (MediaQuery.of(context).size.width/100)*3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 100) * 90,
                  height: (MediaQuery.of(context).size.height / 100) * 10,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                    child: DropdownButton(
                      isExpanded: true,
                      value: selectedService,
                      onChanged: (_value) => secondselected(_value),
                      hint: const Text('Choisissez votre service'),
                      items: [
                        DropdownMenuItem(child: Text("Caisse",style: TextStyle(fontSize: (MediaQuery.of(context).size.width/100)*3),), value: 1),
                      ],
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () => onPressed(
                  '/bank/viewTicket',
                  idBank1,
                  nomBank,
                  imageBank,
                  selectedAgence,
                  selectedRegion,
                  selectedService,
                  selectedDate),
              child: Text('Valider',style: TextStyle(fontSize: (MediaQuery.of(context).size.width/100)*3),),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.grey)),
            ),
          ],
        ));
  }
}
