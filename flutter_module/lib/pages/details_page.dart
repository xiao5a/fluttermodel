import 'package:flutter/material.dart';
import '../provide/details_info_provide.dart';
import '../model/details.dart';
import 'package:provide/provide.dart';
import './details_page/details_page_top.dart';
import 'details_page/detailsexplian.dart';
import 'details_page/details_tabbar.dart';
import 'details_page/details_web.dart';
import 'details_page/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
      ),
      body: 
//      Container(
//        child: Provide<Details_info_provide>(builder: (context, child, data) {
//          return Container(
//            child: Text('商品id${data.goodsdetailmodel.data.goodInfo.goodsName}'),);
//          }
//        ),
//    ),
    
    FutureBuilder(
        future :  _getBackInfo( context),
        builder: (context,snapshot){
        if(snapshot.hasData){
//            return Stack(
            return Stack(
              //关键代码-----------start
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    //关键代码------start
                    Detail_top(),
                    DetailsExplain(),
                    DetailsTabBar(),
                    DetailsWeb(),

                    //关键代码------end
                  ],
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: DetailsBottom()
                )
              ],

            );
        }else{
            return Text('加载中........');
        }

      }
    )
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<Details_info_provide>(context).getGoodsInfo(goodsId);
    return Provide.value<Details_info_provide>(context).goodsdetailmodel;
    print('加载完成............');
  }
}
