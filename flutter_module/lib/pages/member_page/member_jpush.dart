//
//import 'package:flutter/material.dart';
//import 'dart:async';
//import 'package:flutter/services.dart';
//class MemberJpush extends StatefulWidget {
//  @override
//  _MemberJpushState createState() => new _MemberJpushState();
//}
//class _MemberJpushState extends State<MemberJpush> {
//  String debugLable = 'Unknown';   //错误信息
////  final JPush jpush = new JPush();  //初始化极光插件
//  @override
//  void initState() {
//    super.initState();
//    initPlatformState();  //极光插件平台初始化
//  }
//  Future<void> initPlatformState() async {
//    String platformVersion;
//
////    try {
////      //监听响应方法的编写
////      jpush.addEventHandler(
////          onReceiveNotification: (Map<String, dynamic> message) async {
////            print(">>>>>>>>>>>>>>>>>flutter 接收到推送: $message");
////            setState(() {
////              debugLable = "接收到推送: $message";
////            });
////          }
////      );
//
//    } on PlatformException {
//      platformVersion = '平台版本获取失败，请检查！';
//    }
//
//
//    if (!mounted) return;
//
//    setState(() {
//      debugLable = platformVersion;
//    });
//  }
//
//
//
//// 编写视图
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: const Text('极光推送'),
//        ),
//        body: new Center(
//            child: new Column(
//                children:[
//                  new Text('结果: $debugLable\n'),
//                  new FlatButton(
//                      child: new Text('发送推送消息\n'),
//                      onPressed: () {
//                        // 三秒后出发本地推送
//                        var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 3000);
//                        var localNotification = LocalNotification(
//                          id: 234,
//                          title: '技术胖的飞鸽传说',
//                          buildId: 1,
//                          content: '看到了说明已经成功了',
//                          fireTime: fireDate,
//                          subtitle: '一个测试',
//                        );
//                        jpush.sendLocalNotification(localNotification).then((res) {
//                          setState(() {
//                            debugLable = res;
//                          });
//                        });
//
//                      }),
//
//                ]
//            )
//
//        ),
//      ),
//    );
//  }
//}
