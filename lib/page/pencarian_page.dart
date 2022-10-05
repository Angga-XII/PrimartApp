import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:primart/page/item_page.dart';
import 'package:primart/config/item_model.dart';
import 'package:primart/config/settings.dart';

class PencarianPage extends StatefulWidget {
  final String? query;
  List<shopItem>? items = <shopItem>[];
  PencarianPage({this.query, Key? key, this.items}) : super(key: key);
  static const String route = '/pencarian';
  @override
  State<PencarianPage> createState() => _PencarianPageState();
}

class _PencarianPageState extends State<PencarianPage> {
  final _firestore = FirebaseFirestore.instance;
  List<shopItem> items = <shopItem>[];
  final settings = appSettings();

  @override
  void initState() {
    items = widget.items ?? [];
    showLoad();
    // getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('test edinting complote 2 ${widget.query} ${items}');
    return Scaffold(body: getListItem());
  }

  Widget getListItem() {
    // return Text('test get list');
    print('test edinting complote 3 ${items}');
    return (items.length == 0)
        ? Container(child: Text('DATA ${widget.query} tidak ditemukan'))
        : SingleChildScrollView(
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

  Widget showLoad() {
    return CircularProgressIndicator();
  }

  void getList() async {
    // String _query = 'magnum';
    items = <shopItem>[];
    String _query = widget.query ?? '';
    //to do, implement a query method
    items.addAll(await getItems("Nama", _query));
    print("test  ${items}");
    items.addAll(await getItems("Harga", _query));
    setState(() {
      items;
    });
    // getItems("Harga", _query);
    print("testlist akhir ${items}");
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

  Future<dynamic> getItems(String field, String query) async {
    var responses = await _firestore
        .collection('item')
        .orderBy('Nama')
        .startAt([query]).endAt([query + '\uf88ff']).get();
    // _firestore.collection()
    var _tempItems = shopItem().objectToJson(responses);
    // print('test first ${items.contains(_tempItems[0])}');
    return _tempItems.where((element) => checkDuplicate(element.id));
  }

  bool checkDuplicate(String? docsId) {
    bool _isDuplicate = false;
    print('test dup $items $docsId');
    items.isNotEmpty
        ? print('test duplicate 1 ${items[0].id} ${docsId}')
        : print('test duplicate kosong');
    _isDuplicate = (items.where((element) => element.id == docsId)).isEmpty;
    return _isDuplicate;
  }
}
