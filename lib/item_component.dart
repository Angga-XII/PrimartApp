import 'package:flutter/material.dart';
import 'item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settings.dart';

//the model or something for the item
//this page shows the detailed item page
//including a button to edit it
// data shown includes price, images, names, date edited

class itemComponent extends StatefulWidget {
  const itemComponent({Key? key}) : super(key: key);
  @override
  State<itemComponent> createState() => _itemComponentState();
}

class _itemComponentState extends State<itemComponent> {
  final _firestore = FirebaseFirestore.instance;
  List<shopItem> items = <shopItem>[];
  bool isInitialLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    showLoad();
    getItems();
    super.initState();
  }

  void getItems() async {
    var responses = await _firestore.collection('item').get();
    for (var e in responses.docs) {
      var d = shopItem.fromJson(e.data());
      items.add(d);
    }
    setState(() {
      isInitialLoading = false;
    });
    print('test ${items}');
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: getListItem());
  }

  Widget getListItem() {
    // return Text('test get list');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          itemCount: items.length,
          itemBuilder: (context, index) {
            // return Container(height: 10, child: Text('test'));
            return buildList(index);
          },
        ),
      ],
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
            child: itemCard(items[index])),
      ),
    );
  }

  Widget itemCard(shopItem data) {
    return Row(
      children: [
        Text(
          '${data.nama}',
          style: settings().defaultTextStyle,
        ),
        SizedBox(width: 3),
        Text(
          '${data.harga}',
          style: settings().defaultTextStyle,
        ),
        SizedBox(width: 3),
        Text(
          '${data.tanggalMasuk}',
          style: settings().defaultTextStyle,
        ),
      ],
    );
  }

  Widget showLoad() {
    return CircularProgressIndicator();
  }
}
