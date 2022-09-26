import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:primart/page/item_page.dart';
import 'package:primart/config/item_model.dart';
import 'package:primart/config/settings.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);
  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  @override
  void initState() {
    super.initState();
  }

  void getItems() async {}

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('INI BARCODE SCANNER'));
  }

  Widget showLoad() {
    return CircularProgressIndicator();
  }
}
