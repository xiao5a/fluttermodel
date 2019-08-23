import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'dart:convert';
import '../model/details.dart';
import '../service/service_method.dart';

class Details_info_provide with ChangeNotifier  {

  bool isLeft = true;
  bool isRight = false;
  Goodsdetailmodel goodsdetailmodel = null ;
  getGoodsInfo(String id) async{
      var formData = { 'goodId':id, };
       await getRequest('getGoodDetailINfoByID',formData: formData).then((val){
        var responseData= json.decode(val.toString());
        print(responseData);
        goodsdetailmodel=Goodsdetailmodel.fromJson(responseData);
        notifyListeners();
      });
    }
  changeLeftAndRight(String changeState){
    if(changeState=='left'){
      isLeft=true;
      isRight=false;
    }else{
      isLeft=false;
      isRight=true;
    }
    notifyListeners();

  }



}