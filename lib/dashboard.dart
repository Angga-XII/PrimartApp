import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_utils/date_utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:primart/config/settings.dart';
import 'package:primart/page/add_item_page.dart';
import 'package:primart/page/item_component.dart';
import 'package:primart/page/barcode_scanner.dart';
import 'package:primart/page/pencarian_page.dart';
import 'package:primart/page/test_scroll.dart';
import 'package:primart/page/item_list.dart';

//dahsboard include 2 functions menu
//shows a scrollable item list
//a button to add new data to the database

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  static const String route = '/dashboard';
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final settings = appSettings();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Toko Primart"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        // body: Container(child: itemComponent()),
        // body: Container(child: testPage()),
        body: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                  onPressed: _showItemListPage,
                  child: Text('Masuk ke Item List')),
              ElevatedButton(
                  onPressed: _showBarcodePage, child: Text('Masuk ke Barcode')),
              ElevatedButton(
                  onPressed: _showPencarianPage,
                  child: Text('Masuk ke pencarian')),
              ElevatedButton(
                  onPressed: _showTestPage, child: Text('Masuk ke test page')),
            ],
          ),
        ),
      ),
    );
  }

  void _showBarcodePage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => BarcodeScannerPage(),
          fullscreenDialog: true,
        ));
  }

  void _showPencarianPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => PencarianPage(),
          fullscreenDialog: true,
        ));
  }

  void _showTestPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => testPage(),
          fullscreenDialog: true,
        ));
  }

  void _showItemListPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ItemList(),
          fullscreenDialog: true,
        ));
  }
}
