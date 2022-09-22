import 'package:cloud_firestore/cloud_firestore.dart';

class shopItem {
  String? gambar;
  String? nama;
  String? tanggalMasuk;
  String? harga;
  String? id;

  shopItem({this.gambar, this.nama, this.tanggalMasuk, this.harga});

  shopItem.fromJson(Map<String, dynamic> json, String idDocument) {
    gambar = json['Gambar'];
    nama = json['Nama'];
    tanggalMasuk = json['Tanggal Masuk'];
    harga = json['Harga'];
    id = idDocument;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Gambar'] = this.gambar;
    data['Nama'] = this.nama;
    data['Tanggal Masuk'] = this.tanggalMasuk;
    data['Harga'] = this.harga;
    return data;
  }

  List<shopItem> objectToJson(var data) {
    List<shopItem> _listOfItems = [];
    for (var e in data.docs) {
      e.id;
      var d = shopItem.fromJson(e.data(), e.id);
      _listOfItems.add(d);
    }
    return _listOfItems;
  }
}
