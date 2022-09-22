import 'package:flutter/material.dart';
//this page shows the detailed item page
//including a button to edit it
// data shown includes price, images, names, date edited

class itemPage extends StatefulWidget {
  // final String title;
  final String idDoc;
  const itemPage({Key? key, required this.idDoc}) : super(key: key);
  @override
  State<itemPage> createState() => _itemPageState();
}

class _itemPageState extends State<itemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.idDoc),
      ),
    );
  }
}
