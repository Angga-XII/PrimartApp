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

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
  }

  final _firestore = FirebaseFirestore.instance;
  int _counter = 0;
  final settings = appSettings();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Toko Primart'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _showPencarianPage,
            )
          ],
        ),
        // body: Container(child: itemComponent()),
        // body: Container(child: testPage()),
        body: itemComponent(),
        floatingActionButton: FloatingActionButton(
          // onPressed: _incrementCounter,
          onPressed: _showAddItemPage,
          tooltip: 'Tambah Barang baru?',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
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
