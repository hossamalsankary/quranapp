import 'dart:async';

import 'package:flutter/cupertino.dart';

class ReaderProvider extends ChangeNotifier {
  int ayahindex = 0;
  double heights = 0.0;
  Map postions = {};
  Map postionsforplain = {};
  List ayahs;

  void addpos(name, key) {
    postions.addAll({name: key});
    notifyListeners();
  }

  void inc(index) {
    ayahindex = index;
    notifyListeners();
  }

  void increse() {
    Timer(Duration(seconds: 3), () {
      ayahindex++;
      notifyListeners();
    });
  }
}
