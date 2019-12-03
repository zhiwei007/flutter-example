import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'provide/change_skin_provider.dart';
class MusicListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("=============MusicListPage build=====================");
    // TODO: implement build
    return  Provide(builder: ( BuildContext context,  Widget child, ChangeSkinProvider value ){
      return Scaffold(
        appBar:  AppBar(title: Text('Music'),centerTitle: true,backgroundColor: value.getColor),
        body: Container(color: value.getColor),
      );

    });
  }

}