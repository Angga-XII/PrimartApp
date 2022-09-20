import 'package:cloud_firestore/cloud_firestore.dart';

class shopItem {
  String? gambar;
  String? nama;
  String? tanggalMasuk;
  String? harga;

  shopItem({this.gambar, this.nama, this.tanggalMasuk, this.harga});

  shopItem.fromJson(Map<String, dynamic> json) {
    gambar = json['Gambar'];
    nama = json['Nama'];
    tanggalMasuk = json['Tanggal Masuk'];
    harga = json['Harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Gambar'] = this.gambar;
    data['Nama'] = this.nama;
    data['Tanggal Masuk'] = this.tanggalMasuk;
    data['Harga'] = this.harga;
    return data;
  }
}
