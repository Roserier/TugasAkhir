import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tugasakhir/models/Pegawai.dart';
import 'package:tugasakhir/screen/Karyawancreate.dart';

import 'package:tugasakhir/screen/Karyawandetail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    this.refreshIndicator,
  }) : super(key: key);

  final String refreshIndicator;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  bool isDelete;
  List<dynamic> dataPegawai;
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    _loadPegawai();

    widget.refreshIndicator == 'yes' ? refreshList() : dataNull();
  }

  _loadPegawai() async {
    PegawaiModel.loadPegawai().then((value) {
      setState(() {
        dataPegawai = value['data'];
        isLoaded = true;
      });
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    _loadPegawai();
    return null;
  }

  void dataNull() {
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
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KaryawanCreate(),
              ),
            );
          },
          child: Icon(
            Icons.person_add,
            color: Colors.grey[200],
          ),
          backgroundColor: Colors.blue,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await refreshList();
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 210,
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "PT. Sabar Jaya",
                          style: TextStyle(
                            color: Colors.grey[50],
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        width: 230,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Jumlah karyawan"),
                                Row(
                                  children: [
                                    Text(
                                      isLoaded == true
                                          ? dataPegawai.length.toString()
                                          : '-',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.person,
                                      color: Colors.green[400],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Karyawan hadir"),
                                Row(
                                  children: [
                                    Text(
                                      "-",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.business_center,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Jam masuk"),
                                Row(
                                  children: [
                                    Text(
                                      "07:30",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.indigo,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.red[700],
                              ),
                              Text(
                                "Jln. Overste Isdiman no. 13 Purwokerto Timur",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: isLoaded == false ? 50 : 380,
                  child: isLoaded == false
                      ? Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator())
                      : ListPegawai(dataPegawai: dataPegawai),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListPegawai extends StatefulWidget {
  const ListPegawai({
    Key key,
    @required this.dataPegawai,
  }) : super(key: key);

  final List dataPegawai;

  @override
  _ListPegawaiState createState() => _ListPegawaiState();
}

class _ListPegawaiState extends State<ListPegawai> {
  bool isDelete = false;

  Future<Null> _deletePegawai(String id) async {
    PegawaiModel.deletePegawai(id).then((value) {
      showSimpleFlushbar(context, value['message'].toString());
      HomeScreen(
        refreshIndicator: 'yes',
      );
    });

    return null;
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
    return ListView.separated(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      itemCount: widget.dataPegawai.length,
      itemBuilder: (BuildContext context, int i) {
        Map idObj = widget.dataPegawai[i]['_id'];
        ;
        String idString = idObj.values.toString().substring(1, 25);
        var num = i + 1;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KaryawanDetail(
                  id: idString,
                ),
              ),
            );
          },
          child: Dismissible(
            key: new Key(widget.dataPegawai[i].toString()),
            onDismissed: (direction) => _deletePegawai(idString),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              height: 60,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      num.toString(),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 240,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(
                                widget.dataPegawai[i]['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(" (" + widget.dataPegawai[i]['nohp'] + ")"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.red[800],
                            ),
                            Text(widget.dataPegawai[i]['alamat']),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
