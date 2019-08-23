import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currentIndex=0;
  int get value => currentIndex;

  changeIndex(int newIndex){
    currentIndex=newIndex;
    notifyListeners();
  }

}