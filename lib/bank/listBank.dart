import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eticket/class/Bank.dart';
import 'package:eticket/class/Args.dart';

class ListBank extends StatefulWidget {
  @override
  _ListBank createState() => _ListBank();
}

class _ListBank extends State<ListBank> {
  List<Bank> _listbank = [];

  Future<void> fetchBank() async {
    final response =
        await http.get(Uri.parse('http://api.eticket.sn/index.php/showBank'));
    var data1 = response.body;
    var data = jsonDecode(response.body)['data'] as List;
    setState(() {
      _listbank = data.map((BankJson) => Bank.fromJson(BankJson)).toList();
    });
  }

  onPressed(String routeName, idBank,nomBank, imageBank) {
    Args args = Args(idBank,nomBank,imageBank,0,0,0,DateTime.now());
    
    Navigator.of(context).pushNamed(routeName, arguments: args);
  }

  @override
  void initState() {
    super.initState();
    fetchBank();
  }

  Material myItems(String image, String heading, int color, int id) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          shadowColor: Color(0x802196F3),
          borderRadius: BorderRadius.circular(24.0),
          child: InkWell(
            onTap: () => onPressed("/bank/formBank", id,heading,image),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            'http://admin.eticket.sn/img/' + image,
                            height:
                                (MediaQuery.of(context).size.width / 100) * 25,
                            width:
                                (MediaQuery.of(context).size.width / 100) * 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            heading,
                            style: TextStyle(
                              color: new Color(color),
                              fontSize:
                                  (MediaQuery.of(context).size.width / 100) * 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: (MediaQuery.of(context).size.height / 100) * 100,
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(10.0),
                children: _listbank.map((e) {
                  return myItems(e.Image, e.NomBank, 0xff000000, e.IDBank);
                }).toList(),
              )),
        ],
      ),
    );
  }
}
