import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tugasakhir/models/Pegawai.dart';
import 'package:tugasakhir/screen/HomeScreen.dart';

class KaryawanDetail extends StatefulWidget {
  KaryawanDetail({Key key, this.id}) : super(key: key);

  final String id;

  @override
  _KaryawanDetailState createState() => _KaryawanDetailState();
}

class _KaryawanDetailState extends State<KaryawanDetail> {
  bool isLoaded = false;
  Map<String, dynamic> responseJson;

  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController nohpController = TextEditingController();

  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    _loadPegawaiOne();
  }

  void _loadPegawaiOne() async {
    PegawaiModel.loadPegawaiOne(widget.id).then((value) {
      setState(() {
        responseJson = value['data'];
        isLoaded = true;
        namaController.text = responseJson['name'];
        alamatController.text = responseJson['alamat'];
        nohpController.text = responseJson['nohp'];
      });
    });
  }

  void submitUpdate() async {
    PegawaiModel.updatePegawai(widget.id, namaController.text,
            alamatController.text, nohpController.text)
        .then((value) {
      showSimpleFlushbar(context, value['message'].toString());
      refreshList();
    });
  }

  void showSimpleFlushbar(BuildContext context, message) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        color: Colors.blue.shade300,
      ),
      mainButton: FlatButton(onPressed: () {}, child: Text("Click")),
      duration: Duration(seconds: 3),
    )..show(context);
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    _loadPegawaiOne();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              "Karya",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "ONE",
              style: TextStyle(
                color: Colors.grey[200],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await refreshList();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: isLoaded == false
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Nama...",
                            labelText: "Nama Karyawan",
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          controller: namaController,
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Alamat...",
                            labelText: "Alamat Karyawan",
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          controller: alamatController,
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Nomor...",
                            labelText: "Nomor Hp",
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          controller: nohpController,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () => submitUpdate(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                            borderRadius: BorderRadius.circular(7),
                          ),
                          height: 45,
                          width: double.infinity,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Simpan",
                              style: TextStyle(
                                color: Colors.grey[200],
                                fontSize: 15,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
