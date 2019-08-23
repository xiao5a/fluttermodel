import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import 'dart:convert';

Future getHomePageContent() async {
//  try {
//    print("获取数据");
//    Response response;
//    Dio dio = new Dio();
//    dio.options.contentType =
//        ContentType.parse("application/x-www-form-urlencoded");
//    var formData = {'lon': '115.02932', 'lat': '35.76189'};
////    var formData  = {'coderesources': 'ddd'};
//    response = await dio.post(servicePath['homePageContext'], data: formData);
//    if (response.statusCode == 200) {
//      return response.data;
//
//    } else {
//      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
//    }
//  } catch (e) {
//    return print('ERROR:======>${e}');
//  }
  String url = 'homePageContext';
  var formData = {'lon': '115.02932', 'lat': '35.76189'};
  return getTaxRequest(url,formData: formData);

}


Future getTaxRequest(url,{formData}) async {
  try {
    print("获取数据"+url+"开始");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
//    var formData = {'lon': '115.02932', 'lat': '35.76189'};
//    var formData  = {'coderesources': 'ddd'};

    if(formData!=null) {
      response = await dio.post(servicePath[url], data: formData);
    }else{
      response = await dio.post(servicePath[url]);


    }
    if (response.statusCode == 200) {
      return response.data;

    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
