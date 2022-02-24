import 'package:flutter/material.dart';

class Parametre extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Parametre();
  }
}

class _Parametre extends State<Parametre> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
