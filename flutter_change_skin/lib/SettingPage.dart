import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'provide/change_skin_provider.dart';
class SettingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("=============SettingPage build=====================");
    // TODO: implement build
    return  Provide(builder: (BuildContext context,  Widget child, ChangeSkinProvider value){
        return Scaffold(
          appBar:  AppBar(
            title: Text('Setting'),
            centerTitle: true,
            backgroundColor: value.getColor,
          ),
          body: ListView(
            children: <Widget>[
              InkWell(
                  splashColor: value.getColor,
                  child: Card(child: ListTile(title: Text("红色",style: TextStyle(fontSize:25,color: value.getColor),),trailing: Icon(Icons.arrow_forward_ios))),onTap: (){
                Provide.value<ChangeSkinProvider>(context).changeSkin(0);
              }),
              InkWell(
                  splashColor: value.getColor,
                  child: Card(child: ListTile(title: Text("绿色",style: TextStyle(fontSize:25,color: value.getColor)),trailing: Icon(Icons.arrow_forward_ios))),onTap: (){
                Provide.value<ChangeSkinProvider>(context).changeSkin(1);
              }),
              InkWell(
                  splashColor: value.getColor,
                  child: Card(child: ListTile(title: Text("紫色",style: TextStyle(fontSize:25,color: value.getColor)),trailing: Icon(Icons.arrow_forward_ios))),onTap: (){
                Provide.value<ChangeSkinProvider>(context).changeSkin(2);
              }),

            ],
          ),
        );
    });
  }

}