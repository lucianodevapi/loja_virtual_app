import 'package:flutter/cupertino.dart';

class Pagemanager {
  final PageController _pageController;
  int page = 0;

  Pagemanager(this._pageController);

  void setPage(int value) {
    if (page == value) {
      return;
    }
    page = value;
    _pageController.jumpToPage(value);
  }
}
