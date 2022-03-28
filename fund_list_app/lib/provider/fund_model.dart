import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fund_list_app/model/fund.dart';
import 'package:fund_list_app/net/server_api.dart';

class FundModel with ChangeNotifier, DiagnosticableTreeMixin {
  // ignore: deprecated_member_use
  List<Fund> _listFunds = [];
  List<Fund> get fundList => _listFunds;

  bool _isShowIndicator = false;
  bool get isShowIndicator => _isShowIndicator;

  void getFundList() async {
    _isShowIndicator = true;
    notifyListeners(); /*使显示进度圈显示出来*/
    _listFunds = await ServerApi().getFundList2();
    _isShowIndicator = false;
    notifyListeners();
  }
}
