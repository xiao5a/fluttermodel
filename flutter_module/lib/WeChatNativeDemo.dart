import 'package:flutter/material.dart';
import 'wechat_native.dart';
import 'package:flutter/services.dart';

class WeChatNativeDemo extends StatefulWidget {
  _WeChatNativeDemoState createState() => _WeChatNativeDemoState();
}

class _WeChatNativeDemoState extends State<WeChatNativeDemo> {
  String _registrarWeChat = "初始化";
  String _openWechat = "333";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('微信调用示例'),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('注册微信'),
                onPressed: () async {
                  String result = _registrarWeChat;
                  try {
                    result = await WeChatNative.registrarWeChat;
                  } on PlatformException {
                    result = "调用接口异常！";
                  }
                  setState(() {
                    _registrarWeChat = result;
                  });
                },
              ),
              Text('$_registrarWeChat')
            ],
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('打开微信'),
                onPressed: () async {
                  String result = _registrarWeChat;
                  try {
                    result = await WeChatNative.openWeChat;
                  } on PlatformException {
                    result = "调用接口异常！";
                  }
                  setState(() {
                    _openWechat = result;
                  });
                },
              ),
              Text('$_openWechat')
            ],
          )
        ],
      ),
    );
  }
}
