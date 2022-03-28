// {fundcode: 001606, name: 农银工业4.0混合, jzrq: 2020-11-24, dwjz: 2.8815, gsz: 2.8525, gszzl: -1.01, gztime: 2020-11-25 10:33}

class Fund {
  String fundcode;
  String name;
  String jzrq;
  String dwjz;
  String gsz;
  String gszzl;
  String gztime;
  Fund.name(
      {required this.fundcode,
      required this.name,
      required this.jzrq,
      required this.dwjz,
      required this.gsz,
      required this.gszzl,
      required this.gztime});

  @override
  String toString() {
    return 'Fund{fundcode: $fundcode, name: $name, jzrq: $jzrq, dwjz: $dwjz, gsz: $gsz, gszzl: $gszzl, gztime: $gztime}';
  }

  // factory Fund.fromJson(Map<String, dynamic> json) => jsonToFund(json);

  static Fund jsonToFund(Map<String, dynamic> json) {
    return Fund.name(
      fundcode: json['fundcode'],
      name: json['name'],
      jzrq: json['jzrq'],
      dwjz: json['dwjz'],
      gsz: json['gsz'],
      gszzl: json['gszzl'],
      gztime: json['gztime'],
    );
  }
}
