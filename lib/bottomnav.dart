import 'package:flutter/material.dart';
import 'package:eticket/dashboard.dart';
import 'package:eticket/tickets.dart';
import 'package:eticket/parametre.dart';

class BottomNav extends StatefulWidget {
  //TODO session and login integration
  @override
  State<StatefulWidget> createState() {
    return _BottomNav();
  }
}

class _BottomNav extends State<BottomNav> {
  late PageController _pageController;
  int _page = 0;
  String _title = "Dashboard";

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(microseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
      if (page == 0)
        _title = "Tickets";
      else if (page == 1)
        _title = "Dashboard";
      else
        _title = "Paramètre";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView(
        children: [
          new Tickets(),
          new Dashboard(),
          new Parametre()
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.purple,
        onTap: navigationTapped,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.confirmation_num),
            label: 'Tickets',
            ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.dashboard),
            label: 'Dashboard',
            ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            label: 'Paramètre',
            ),
        ],
      ),
    );
  }
}
