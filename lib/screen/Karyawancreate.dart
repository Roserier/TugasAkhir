import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tugasakhir/models/Pegawai.dart';

class KaryawanCreate extends StatefulWidget {
  @override
  _KaryawanCreateState createState() => _KaryawanCreateState();
}

class _KaryawanCreateState extends State<KaryawanCreate> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();

  void submitData() async {
    if (namaController.text != '' &&
        alamatController.text != '' &&
        nohpController.text != '') {
      PegawaiModel.simpanPegawai(
              namaController.text, alamatController.text, nohpController.text)
          .then((value) {
        FocusScope.of(context).requestFocus(new FocusNode());
        showSimpleFlushbar(context, value['message'].toString());
      });
    } else {
      showSimpleFlushbar(context, 'Mohon lengkapi data!');
    }
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
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
                  textCapitalization: TextCapitalization.words,
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
                  keyboardType: TextInputType.number,
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
                onTap: () => submitData(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
    );
  }
}
