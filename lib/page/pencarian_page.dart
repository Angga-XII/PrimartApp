import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:primart/page/item_page.dart';
import 'package:primart/config/item_model.dart';
import 'package:primart/config/settings.dart';

class PencarianPage extends StatefulWidget {
  const PencarianPage({Key? key}) : super(key: key);
  static const String route = '/pencarian';
  @override
  State<PencarianPage> createState() => _PencarianPageState();
}

class _PencarianPageState extends State<PencarianPage> {
  @override
  void initState() {
    super.initState();
  }

  void getItems() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('INI PAGE PENCARIAN')));
  }

  Widget showLoad() {
    return CircularProgressIndicator();
  }
}
