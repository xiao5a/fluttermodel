import 'package:flutter/material.dart';
import '../model/category.dart';
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int tindex = 0;
  String categoryId = '4';
  String subcategoryId='';//子类id
  int page=1;  //列表页数，当改变大类或者小类时进行改变
  String noMoreText=''; //显示更多的标识
  getChildCategory(List<BxMallSubDto> list,String id){
    tindex = 0;
    categoryId = id;
    BxMallSubDto bxMallSubDto = BxMallSubDto();
    bxMallSubDto.mallSubId='';
    bxMallSubDto.mallCategoryId='00';
    bxMallSubDto.mallSubName='全部';
    bxMallSubDto.comments='null';
    page=1;
    noMoreText = ''; //显示更多的表示
    childCategoryList = [bxMallSubDto];
    childCategoryList.addAll(list);
    notifyListeners();
  }
  changeIndex(index,subid){
    tindex = index;
    subcategoryId = subid;
    page=1;
    noMoreText = ''; //显示更多的表示
    notifyListeners();
  }
  getNoMoreText(text){
    noMoreText = text;
    notifyListeners();

  }
  addPage(){
    page++;
  }
}