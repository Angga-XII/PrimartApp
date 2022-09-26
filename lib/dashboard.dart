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

//dahsboard include 2 functions menu
//shows a scrollable item list
//a button to add new data to the database

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardPage(title: 'Toko Primart'),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _firestore = FirebaseFirestore.instance;
  int _counter = 0;
  final settings = appSettings();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                  onPressed: _showBarcodePage, child: Text('Masuk ke barcode')),
              ElevatedButton(
                  onPressed: _showPencarianPage,
                  child: Text('Masuk ke pencarian')),
              Container(child: itemComponent()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // onPressed: _incrementCounter,
          onPressed: _showAddItemPage,
          tooltip: 'Tambah Barang baru?',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
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

  void _showAddItemPage() async {
    showMaterialModalBottomSheet(
      isDismissible: true,
      context: context,
      expand: false,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Center(
                  child: Text(
                'Tambah Barang baru',
                style: settings.titleTextStyle,
              )),
              color: Colors.blue,
              width: double.infinity,
              height: 50,
            ),
            addItemPage(),
          ],
        );
      },
    );
  }
}
