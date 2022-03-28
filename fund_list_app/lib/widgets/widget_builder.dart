import 'package:flutter/material.dart';

Widget buildRowCell(String left, String right) => Padding(
    padding: EdgeInsets.all(10),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        flex: 1,
        child: Text(
          "$left",
        ),
      ),
      Expanded(
        flex: 1,
        child: Text(
          "$right",
          textAlign: TextAlign.end,
        ),
      ),
    ]));

Widget buildRowCell2(String left, String right) {
  try {
    var _myDouble = double.parse(right);
    var _color = _myDouble > 0 ? Colors.redAccent : Colors.green;
    return Padding(
        padding: EdgeInsets.all(10),
        child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1, child: Text(left)),
              Expanded(
                  flex: 1,
                  child: Text(right + "%",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _color,
                      )))
            ]));
  } catch (e) {
    return Text(e.toString());
  }
}

Widget buildProgressbar() {
  return Center(child: CircularProgressIndicator());
}
