import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';


class Routers{
  static String root='/';
  static String detailsPage = '/detail';
  static String mapPage = '/map';
  static String jpushPage = '/jpush';

  static void configureRoutes(Router router){
    router.notFoundHandler= new Handler(
        handlerFunc: (BuildContext context,Map<String,List<String>> params){
          print('ERROR====>ROUTE WAS NOT FONUND!!!');
        }
    );
    router.define(detailsPage,handler:detailsHandler);
//    router.define(mapPage,handler:MapHandler);
//    router.define(jpushPage,handler:JpushHandler);


  }

}