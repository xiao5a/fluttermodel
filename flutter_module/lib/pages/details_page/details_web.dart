import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info_provide.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsWeb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var goodsDetail=Provide.value<Details_info_provide>(context).goodsdetailmodel.data.goodInfo.goodsDetail;
    return  Provide<Details_info_provide>(

      builder: (context,child,val){
        var isLeft = Provide.value<Details_info_provide>(context).isLeft;
        if(isLeft){
          return  Container(
            child: Html(
                data:goodsDetail
            ),
          );
        }else{
          return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text('暂时没有数据')
          );
        }
      },
    );
  }
}