import 'package:hive_flutter/adapters.dart';

import 'fundcode_list.dart';

const fund_code = 'fund_code';

class FundCodeStore {
  late Box<String> _mBox;

  Future<void> initStore() async {
    await Hive.initFlutter();
    _mBox = await Hive.openBox<String>(fund_code);
  }

  Box<String> get getBox => _mBox;

  void importDefualtList() {
    print("==============initFundList================");
    for (String it in fundCodeList) {
      getBox.put(it, it);
    }

    print("==============_Boxlist================");
    print(getList().toString());
  }

  void addItem(String s) {
    getBox.put(s, s);
  }

  void delItem(String item) {
    getBox.delete(item);
  }

  List getList() {
    return getBox.values.toList();
  }
}
