// import 'dart:html';

import 'package:flutter/material.dart';
import 'item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settings.dart';

//the model or something for the item
//this page shows the detailed item page
//including a button to edit it
// data shown includes price, images, names, date edited

class addItemPage extends StatefulWidget {
  const addItemPage({Key? key}) : super(key: key);
  @override
  State<addItemPage> createState() => _addItemPageState();
}

class _addItemPageState extends State<addItemPage> {
  final _firestore = FirebaseFirestore.instance;
  List<shopItem> items = <shopItem>[];
  bool isInitialLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getItems() async {}

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: Duration(milliseconds: 500),
      child: Material(
        child: SafeArea(
          top: true,
          child: Text('test modal botom'),
        ),
      ),
    );
  }

  Widget showLoad() {
    return CircularProgressIndicator();
  }
}
