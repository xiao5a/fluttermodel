import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cartprovider.dart';
class CartCount extends StatelessWidget {
  var item;
  CartCount(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black12)),
      child: Row(
      children: <Widget>[
        _radiosBtn(context),
        _midleCount(context),
        _AddBtn(context),
      ],

      ),

    );
  }

  Widget _radiosBtn(context){

    return InkWell(
      onTap: (){
        Provide.value<CartProvider>(context).addOrReduceAction(item,'-');

      }

      ,
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: item.count>=1?Colors.white:Colors.black12,

          border:Border(right: BorderSide(color: Colors.black12,width: 1),
            ),


        ),
        child:item.count>=1? Text('-'):Text(' '),
      ),
    );
  }
Widget _midleCount(context){
    
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
}
  Widget _AddBtn(context){

    return InkWell(
      onTap: (){
        Provide.value<CartProvider>(context).addOrReduceAction(item,'+');

      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:Border(left: BorderSide(color: Colors.black12,width: 1),
          ),
        ),
        child: Text('+'),
      ),
    );
  }
}
