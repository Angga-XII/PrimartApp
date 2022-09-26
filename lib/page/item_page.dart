import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:primart/config/settings.dart';
import 'package:primart/config/item_model.dart';

//this page shows the detailed item page
//including a button to edit it
// data shown includes price, images, names, date edited

class itemPage extends StatefulWidget {
  // final String title;
  final shopItem item;
  const itemPage({Key? key, required this.item}) : super(key: key);
  @override
  State<itemPage> createState() => _itemPageState();
}

class _itemPageState extends State<itemPage> {
  final settings = appSettings();
  final _firestore = FirebaseFirestore.instance;
  shopItem items = shopItem();
  var _namaController = TextEditingController();
  var _hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL ITEM"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network('https://picsum.photos/250?image=9'),
            ),
          ),
          _itemCard('Nama Barang :', widget.item.nama!),
          SizedBox(height: 10),
          _itemCard('Harga Barang :', widget.item.harga!),
          SizedBox(height: 10),
          _itemCard('Terakhir diubah :', widget.item.tanggalMasuk!),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _resetData,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 2),
                    Text('Hapus', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: _saveData,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.save),
                    SizedBox(width: 2),
                    Text('Simpan', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemCard(String title, String body) {
    return InkWell(
      child: Card(
        child: InputDecorator(
          decoration: InputDecoration(
            label: Text(
              title,
              style: settings.hintTextStyle,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.green,
                width: 1,
              ),
            ),
          ),
          child: Text(
            body,
            style: settings.defaultTextStyle,
          ),
        ),
      ),
    );
  }

  void _saveData() {
    DateTime _now = DateTime.now();
    var _data = {
      //   'Gambar': '}.jpg',
      'Nama': '${_namaController.text}',
      'Tanggal Masuk': _now.toIso8601String(),
      'Harga': 'Rp.${_hargaController.text}',
    };
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      // animType: AnimType.rightSlide,
      title: 'Simpan Barang?',
      desc: 'Apa anda yakin anda ingin menyimpan barang ini?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _firestore.collection('item').add(_data);
      },
    ).show();
    print('test ${_namaController.text} ${_hargaController.text}');
  }

  void _resetData() {
    setState(() {
      _namaController.clear();
      _hargaController.clear();
    });
    print('test reset ${_namaController.text} ${_hargaController.text}');
  }
}
