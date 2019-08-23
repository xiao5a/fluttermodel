import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';
import '../pages/member_page/member_Map.dart';
import '../pages/member_page/member_jpush.dart';
Handler detailsHandler =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      String goodsId = params['id'].first;
      print('index>details goodsID is ${goodsId}');
      return DetailsPage(goodsId);
    }


);

//Handler MapHandler =Handler(
//    handlerFunc: (BuildContext context,Map<String,List<String>> params){
//      return memberMapPage();
//    }
//
//
//);
//
//
//Handler JpushHandler =Handler(
//    handlerFunc: (BuildContext context,Map<String,List<String>> params){
//      return MemberJpush();
//    }
//
//
//);