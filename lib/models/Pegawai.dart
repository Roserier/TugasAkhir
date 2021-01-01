import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PegawaiModel {
  String id;
  String name;
  String alamat;
  String nohp;

  PegawaiModel({
    this.id,
    this.name,
    this.alamat,
    this.nohp,
  });

  factory PegawaiModel.fromJSON(Map<String, dynamic> json) => PegawaiModel(
        id: json['_id'],
        name: json['name'],
        alamat: json['alamat'],
        nohp: json['nohp'],
      );

  static Future loadPegawai() async {
    Uri uri = Uri.http('192.168.100.7:5000', '/pegawai');

    Response response = await http.get(uri);

    var jsonObject = jsonDecode(response.body);
    return jsonObject;
  }

  static Future loadPegawaiOne(String id) async {
    Uri uri = Uri.http('192.168.100.7:5000', '/pegawai/$id');

    Response response = await http.get(uri);

    var jsonObject = jsonDecode(response.body);
    return jsonObject;
  }

  static Future simpanPegawai(String name, String alamat, String nohp) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    Uri uri = Uri.http('192.168.100.7:5000', '/pegawai');

    final postData = jsonEncode({'name': name, 'alamat': alamat, 'nohp': nohp});

    Response response = await http.post(uri, headers: headers, body: postData);

    var jsonObject = jsonDecode(response.body);
    return jsonObject;
  }

  static Future updatePegawai(
      String id, String name, String alamat, String nohp) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };

    Uri uri = Uri.http('192.168.100.7:5000', '/pegawai/$id');
    final postData =
        jsonEncode({'id': id, 'name': name, 'alamat': alamat, 'nohp': nohp});

    Response response = await http.put(uri, headers: headers, body: postData);

    var jsonObject = jsonDecode(response.body);
    return jsonObject;
  }

  static Future deletePegawai(String id) async {
    Uri uri = Uri.http('192.168.100.7:5000', '/pegawai/$id');

    Response response = await http.delete(uri);

    var jsonObject = jsonDecode(response.body);
    return jsonObject;
  }
}
