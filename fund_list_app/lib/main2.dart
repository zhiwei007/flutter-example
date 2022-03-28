import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/data_store.dart';

void main() async {
  FundCodeStore fundCodeStore = FundCodeStore() ;
  fundCodeStore.initStore();
  WidgetsApp.debugAllowBannerOverride = false;
  runApp(MaterialApp(
    home: MyApp.name( fundCodeStore ),
  ));
}

class MyApp extends StatefulWidget {
  FundCodeStore _fundCodeStore;
  MyApp.name(this._fundCodeStore );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyPage( _fundCodeStore);
  }
}

class MyPage extends State {
  FundCodeStore _fundCodeStore;
  MyPage(this._fundCodeStore);
  @override
  void initState() {
    print("==============initState================");
    _fundCodeStore.importDefualtList();
  }
  @override
  Widget build(BuildContext context) {
    print("========================build==============================");
    // TODO: implement build
    var  _Boxlist =  _fundCodeStore.getList();
    print("_Boxlist len=====> ${_Boxlist.length}");
    print("_Boxlist=====>" + _Boxlist.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive  test"),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                child: Icon(Icons.add, size: 40, color: Colors.black54),
                onTap: () {
                  String tmp = "99999999";
                  _fundCodeStore.addItem(tmp);
                },
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                child: Icon(Icons.refresh, size: 40, color: Colors.black54),
                onTap: () {
                  _Boxlist = _fundCodeStore.getBox.values.toList();
                  print(_Boxlist.toString());
                },
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                child:
                    Icon(Icons.delete_forever, size: 40, color: Colors.black54),
                onTap: () {
                  _fundCodeStore. delItem("001579");
                },
              )),
        ],
      ),
      body: ListWheelScrollView(itemExtent: 1, children: [
        Text("dsad"),
        Padding(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
                itemCount: _Boxlist.length,
                itemBuilder: (BuildContext context, int index) {
                  return _Boxlist.length == 0
                      ? Text("No data")
                      : Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("${_fundCodeStore.getList()[index]}"));
                }))
      ]),
    );
  }
}
