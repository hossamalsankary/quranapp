import 'package:flutter/cupertino.dart';

class HoldData extends ChangeNotifier {
  Map quran, tafseer;
  List azkar;
  int ayahindex = 1;
  int speed = 5;
  double fontSize = 30;
  FontWeight fontWight = FontWeight.w100;

  List<Map> postions = [];
  List holdquran = [];
  List holdtafseerdata = [];
  List fakedata = [
    {"text": "مرحبان ياصديق نحن نقدم لك ايات من كتاب الله ", "isq": false},
  ];
  int index = 0;
  List leavelsforquran = [];
  List leavelsfortafseer = [];

  List<FontWeight> fontwightdata = [
    FontWeight.w100,
    FontWeight.w200,
    FontWeight.w300,
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w900,
    FontWeight.bold
  ];

  void changespeedincress() {
    speed++;
    notifyListeners();
  }

  void changespeeddecress() {
    speed <= 0 ? speed = 10 : speed--;
    notifyListeners();
  }

  chatadd(Map data) {
    fakedata.add(data);
    notifyListeners();
  }

  void changefontdecress() {
    this.fontWight = fontwightdata[index];
    index == 0 ? index = 0 : index--;
    notifyListeners();
  }

  void changefontincress() {
    this.fontWight = fontwightdata[index];
    index == fontwightdata.length - 1
        ? index = fontwightdata.length - 1
        : index++;
    notifyListeners();
  }

  void incfont() {
    fontSize <= 72.0 ? fontSize++ : fontSize = 72.0;
    notifyListeners();
  }

  void decfont() {
    fontSize >= 19.0 ? fontSize-- : fontSize = 19.0;
    notifyListeners();
  }

  void addindex(int index) {
    this.ayahindex = index;
    notifyListeners();
  }

  void addData({@required quran, @required tafseer, @required azkar}) {
    try {
      this.quran = quran;
      this.azkar = azkar;
      this.tafseer = tafseer;
    } catch (e) {
      print("Sorry Cant Load Json Fils right now /n $e ");
      this.quran = {};
      this.azkar = [];
      this.tafseer = {};
    }
  }
}
