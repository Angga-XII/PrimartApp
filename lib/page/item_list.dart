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
import 'package:primart/config/item_model.dart';

class ItemList extends StatefulWidget {
  static const String route = '/item_list';
  const ItemList({Key? key}) : super(key: key);
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final _firestore = FirebaseFirestore.instance;
  bool isPencarian = false;
  final settings = appSettings();
  var _pencarianController;
  Widget _body = Container();
  List<shopItem> items = <shopItem>[];

  @override
  void initState() {
    setState(() {
      _body = showLoad();
      isPencarian = false;
      _pencarianController = TextEditingController();
    });
    getAllItems();
    super.initState();
  }

  void getAllItems() async {
    var responses = await _firestore.collection('item').get().then((value) {
      items = shopItem().objectToJson(value);
      setState(() {
        items;
      });
    });
    // items = shopItem().objectToJson(responses);
    // print('test object $_test');
    setState(() {
      _body = itemComponent(items: items);
    });
    print('test ${items}');
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

  void getQueryList() async {
    // String _query = 'magnum';
    String _query = _pencarianController.text;
    //to do, implement a query method
    items.addAll(await searchItems("Nama", _query));
    print("test pencarian  ${items}");
    items.addAll(await searchItems("Harga", _query));
    setState(() {
      _body = itemComponent(items: items);
      // _body = PencarianPage(
      //   items: items,
      // );
    });
    // getItems("Harga", _query);
    print("testlist akhir ${items}");
  }

  Future<dynamic> searchItems(String field, String query) async {
    var responses = await _firestore
        .collection('item')
        .orderBy('Nama')
        .startAt([query]).endAt([query + '\uf88ff']).get();
    var _tempItems = shopItem().objectToJson(responses);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: isPencarian
              ? TextField(
                  controller: _pencarianController,
                  style: settings.titleTextStyle,
                  onEditingComplete: () {
                    print(
                        'test edinting complote 1 ${_pencarianController.text}');
                    setState(() {
                      items = <shopItem>[];
                      getQueryList();
                    });
                  },
                )
              : Text('Toko Primart'),
          leading: IconButton(
              icon: isPencarian
                  ? Icon(Icons.backspace_outlined)
                  : Icon(Icons.close),
              onPressed: () {
                isPencarian
                    ? setState(() {
                        getAllItems();
                        isPencarian = false;
                        _pencarianController.clear();
                        _body = itemComponent(items: items);
                      })
                    : Navigator.pop(context);
              }),
          centerTitle: true,
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isPencarian = true;
                });
              },
            )
          ],
        ),
        // body: isPencarian ? PencarianPage() : itemComponent(),
        body: _body,
        floatingActionButton: FloatingActionButton(
          // onPressed: _incrementCounter,
          onPressed: _showAddItemPage,
          tooltip: 'Tambah Barang baru?',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget showLoad() {
    return Center(child: CircularProgressIndicator());
  }
}
