/** * 调用微信SDK */
import 'dart:async';
import 'package:flutter/services.dart';
class WeChatNative {
  //管道名称
  static const MethodChannel _channel =MethodChannel('wechat');
  //微信注册
static Future<String> get registrarWeChat async{
  final String result = await _channel.invokeMethod('registrarWeChat');
  return result;
} //打开微信注册
 static Future<String> get openWeChat async{
  final String result = await _channel.invokeMethod('openWeChat');
  return result;
}
}
