import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info_provide.dart';
import '../../provide/cartprovider.dart';
import '../../model/cart.dart';
import '../../provide/currentIndex.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<Details_info_provide>(context).goodsdetailmodel;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(80),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Provide.value<CurrentIndexProvide>(context).changeIndex(1);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(110),
                    height: ScreenUtil().setHeight(80),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.red,
                      size: 35,
                    ),
                  )),

              Provide<CartProvider>(builder: (context, child, val) {
                int goodsCount =
                    Provide.value<CartProvider>(context).allGoodsCount;
                return Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Text(
                        '${goodsCount}',
                        style: TextStyle(color: Colors.white,
                            fontSize: ScreenUtil().setSp(22)
                        ),

                      ),
                    ));
              })

//
            ],
          ),
          InkWell(
            onTap: () async {
              Map<String, dynamic> json = {
                'goodsId': goodsInfo.data.goodInfo.goodsId,
                'goodsName': goodsInfo.data.goodInfo.goodsName,
                'count': 1,
                'price': goodsInfo.data.goodInfo.presentPrice,
                'images': goodsInfo.data.goodInfo.image1,
                'isCheck': true //是否已经选择
              };
              CartModel cart = CartModel.fromJson(json);

              await Provide.value<CartProvider>(context).save(cart);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                '加入购物车',
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvider>(context).removeallcart();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text(
                '立即购买',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
