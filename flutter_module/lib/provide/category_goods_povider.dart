import 'package:flutter/material.dart';
import '../model/categorygoodslist.dart';
import 'package:provide/provide.dart';
class CategoryGoodsListProvider with ChangeNotifier {
  List<GoodsListData>  categoryGoodsList = [];
  getCategoryGoodsList(List<GoodsListData> list){
    categoryGoodsList=list;
    notifyListeners();
  }
  moreGoodsList(List<GoodsListData> list){
    categoryGoodsList.addAll(list);
    notifyListeners();
  }
}