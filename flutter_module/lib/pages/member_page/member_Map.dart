//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:amap_base/amap_base.dart';
//import '../../application/application.dart';
//class memberMapPage extends StatelessWidget {
//  AMapController _controller;
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Container(
//      child: Scaffold(
//        appBar: AppBar(title: Text('会员中心')),
////        body: ListView(
////          children: <Widget>[
////            _topHeader(),
////            _orderTitle(),
////            _orderType(),
////            _actionList(context),
////          ],
////        ),
//        body:AMapView(
//          onAMapViewCreated: (controller) {
//          _controller = controller;
//        },
//        amapOptions: AMapOptions(
//          compassEnabled: false,
//          zoomControlsEnabled: true,
//          logoPosition: LOGO_POSITION_BOTTOM_CENTER,
//          camera: CameraPosition(
//          target: LatLng(41.851827, 112.801637),
//          zoom: 4,
//          ),
//        ),
//        ),
//
//      ),
//    );
//  }
//  Widget _topHeader() {
//    return Container(
//      width: ScreenUtil().setWidth(750),
//      padding: EdgeInsets.all(20),
//      color: Colors.pinkAccent,
//      child: Column(
//        children: <Widget>[
//          Container(
//            height: ScreenUtil().setHeight(200),
//            margin: EdgeInsets.only(top: 30),
//            child: ClipOval(
//                child:Image.network('https://tfs.alipayobjects.com/images/partner/T1QxpcXn8PXXXXXXXX',fit: BoxFit.scaleDown,)
//            ),
//          ),
//          Container(
//            child: Text(
//              '小5啊',
//              style: TextStyle(
//                fontSize: ScreenUtil().setSp(36),
//                color:Colors.white,
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//
//  }
//
//  Widget _orderTitle(){
//
//    return Container(
//      margin: EdgeInsets.only(top:10),
//      decoration: BoxDecoration(
//          color: Colors.white,
//          border: Border(
//              bottom:BorderSide(width: 1,color:Colors.black12)
//          )
//      ),
//      child: ListTile(
//        leading: Icon(Icons.list),
//        title:Text('我的订单'),
//        trailing: Icon(Icons.arrow_right),
//      ),
//    );
//
//  }
//
//  Widget _orderType(){
//    return Container(
//      margin: EdgeInsets.only(top: 5),
//      padding: EdgeInsets.only(top:10),
//      alignment: Alignment.center,
//
//      child: Row(
//          children: <Widget>[
//            Container(
//              width: ScreenUtil().setWidth(187),
//              child: Column(
//                children: <Widget>[
//                  Icon(
//                    Icons.party_mode,
//                    size: 30,
//                  ),
//                  Text('待付款'),
//                ],
//              ),
//            ),
//            //-----------------
//            Container(
//              width: ScreenUtil().setWidth(187),
//              child: Column(
//                children: <Widget>[
//                  Icon(
//                    Icons.query_builder,
//                    size: 30,
//                  ),
//                  Text('待发货'),
//                ],
//              ),
//            ),
//            //-----------------
//            Container(
//              width: ScreenUtil().setWidth(187),
//              child: Column(
//                children: <Widget>[
//                  Icon(
//                    Icons.directions_car,
//                    size: 30,
//                  ),
//                  Text('待收货'),
//                ],
//              ),
//            ),
//            Container(
//              width: ScreenUtil().setWidth(187),
//              child: Column(
//                children: <Widget>[
//                  Icon(
//                    Icons.content_paste,
//                    size: 30,
//                  ),
//                  Text('待评价'),
//                ],
//              ),
//            ),
//          ]
//      ),
//    );
//
//  }
//
//  Widget _myListTile(String title){
//
//    return Container(
//      decoration: BoxDecoration(
//          color: Colors.white,
//          border: Border(
//              bottom:BorderSide(width: 1,color:Colors.black12)
//          )
//      ),
//      child: ListTile(
//        leading: Icon(Icons.blur_circular),
//        title: Text(title),
//        trailing: Icon(Icons.arrow_right),
//      ),
//    );
//  }
//  Widget _actionList(context){
//    return Container(
//      margin: EdgeInsets.only(top: 10),
//      child: Column(
//        children: <Widget>[
//          _myListTile('领取优惠券'),
//          _myListTile('已领取优惠券'),
//          InkWell(
//            onTap: (){
//
//            },
//            child:  _myListTile('地址管理'),
//
//          ),
//          _myListTile('客服电话'),
//          _myListTile('关于我们'),
//        ],
//      ),
//    );
//  }
//
//
//}
