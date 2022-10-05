import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:primart/page/item_page.dart';
import 'package:primart/config/item_model.dart';
import 'package:primart/config/settings.dart';
import 'package:primart/page/test_scroll.dart';

class itemComponent extends StatefulWidget {
  List<shopItem>? items = <shopItem>[];
  itemComponent({this.items, Key? key}) : super(key: key);
  @override
  State<itemComponent> createState() => _itemComponentState();
}

class _itemComponentState extends State<itemComponent> {
  final _firestore = FirebaseFirestore.instance;
  List<shopItem> items = <shopItem>[];
  bool isInitialLoading = true;
  final settings = appSettings();

  @override
  void initState() {
    // TODO: implement initState
    // items = widget.items ?? [];
    // print('test comp ${items}');
    showLoad();
    // getItems();
    super.initState();
  }

  void getItems() async {
    var responses = await _firestore.collection('item').get();
    items = shopItem().objectToJson(responses);
    // print('test object $_test');
    setState(() {
      isInitialLoading = false;
    });
    print('test ${items}');
  }

  @override
  Widget build(BuildContext context) {
    items = widget.items ?? [];
    print('test comp ${items}');
    return items.length == 0 ? Container(child: Text('TEXT')) : getListItem();
  }

  Widget getListItem() {
    // return Text('test get list');
    return SingleChildScrollView(
      // child: _testList()
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: items.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              // return Container(height: 10, child: Text('test'));
              return buildList(index);
            },
          ),
        ],
      ),
    );
  }

  Widget buildList(int index) {
    return Center(
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InputDecorator(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
            ),
            child: _itemCard(items[index])),
      ),
    );
  }

  Widget _itemCard(shopItem data) {
    return InkWell(
      onTap: () => goToPage(data),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Barang :'),
              Text('Harga Barang :'),
              Text('Terakhir diubah :'),
            ],
          ),
          SizedBox(width: 3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.nama}',
                style: settings.defaultTextStyle,
              ),
              Text(
                '${data.harga}',
                style: settings.defaultTextStyle,
              ),
              Text(
                '${data.tanggalMasuk}',
                style: settings.defaultTextStyle,
              ),
            ],
          ),
          SizedBox(width: 10),
          // Icon(Icons.mail),
        ],
      ),
    );
  }

  Future goToPage(shopItem data) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ItemPage(
            item: data,
          ),
          fullscreenDialog: true,
        ));
  }

  Widget showLoad() {
    return CircularProgressIndicator();
  }
}
