class shopItem {
  String? gambar;
  String? nama;
  String? tanggalMasuk;
  String? harga;
  String? id = '';

  shopItem({this.gambar, this.nama, this.tanggalMasuk, this.harga, this.id});

  shopItem.fromJson(Map<String, dynamic> json, String idDocument) {
    gambar = json['Gambar'];
    nama = json['Nama'];
    tanggalMasuk = json['Tanggal Masuk'].toString().substring(0, 10);
    harga = json['Harga'];
    id = idDocument;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Gambar'] = this.gambar;
    data['Nama'] = this.nama;
    data['Tanggal Masuk'] = this.tanggalMasuk;
    data['Harga'] = this.harga;
    data['Id'] = this.id;
    return data;
  }

  List<shopItem> objectToJson(var data) {
    List<shopItem> _listOfItems = [];
    for (var e in data.docs) {
      var d = shopItem.fromJson(e.data(), e.id);
      _listOfItems.add(d);
    }
    return _listOfItems;
  }

  bool checkIfDuplicate(List<dynamic> reference, var comparison) {
    // bool isDuplicate = false;
    // reference.forEach((element)=> elem);
    // List<shopItem> _listOfItems = [];
    // for (var e in data.docs) {
    //   var d = shopItem.fromJson(e.data(), e.id);
    //   _listOfItems.add(d);
    // }
    // return _listOfItems;
    return false;
  }
}
