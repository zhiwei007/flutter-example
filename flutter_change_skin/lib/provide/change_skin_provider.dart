import 'package:flutter/material.dart';

class ChangeSkinProvider extends ChangeNotifier{
       List<Color>  _list = const [Colors.pinkAccent,Colors.green,Colors.deepPurpleAccent];

       Color  _color = Colors.blue;

       Color  get  getColor=>_color;

      void changeSkin(int index){
          _color = _list[index];
          notifyListeners();
      }
}