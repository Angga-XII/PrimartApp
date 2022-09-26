import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:primart/config/item_model.dart';
import 'package:primart/config/settings.dart';

//the config or something for the item
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
  shopItem items = shopItem();
  bool isInitialLoading = true;
  final settings = appSettings();
  var _namaController = TextEditingController();
  var _hargaController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: Duration(milliseconds: 500),
      child: SafeArea(
        top: false,
        child: inputArea(),
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

  Widget inputArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          inputCard('Nama barang', 'Masukan nama barang', _namaController),
          SizedBox(height: 10),
          inputCard('Harga barang', 'Masukan harga barang', _hargaController),
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
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget inputCard(String? title, String? input, _control) {
    return Card(
        child: InputDecorator(
            decoration: InputDecoration(
              label: Text(title!),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
            ),
            child: TextField(
              controller: _control,
            )
            // Text(
            //   input!,
            //   style: settings.hintTextStyle,)
            ));
  }

  Widget showLoad() {
    return CircularProgressIndicator();
  }
}
