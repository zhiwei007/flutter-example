import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'provide/change_skin_provider.dart';
class BookListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Provide(builder: ( BuildContext context,  Widget child, ChangeSkinProvider value ){
      return Scaffold(
        appBar:  AppBar(title: Text('Book'),centerTitle: true,backgroundColor: value.getColor),
        body: Container(color: value.getColor),
      );

    });
  }

}