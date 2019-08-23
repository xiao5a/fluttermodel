import 'package:flutter/material.dart';
import '../model/cart.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier{
  List<CartModel> cartList = [];
  String  cartString = '[]' ;
  double allPrice =0 ;   //总价格
  int allGoodsCount =0;  //商品总数量
  bool isAllCheck= true; //是否全选

  save(CartModel cart) async {

    //初始化SharedPreferences
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo') ;  //获取持久化存储的值
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    //如果有值进行decode操作
    var temp=cartString==null?[]:json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList= (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave= false;  //默认为没有
    int ival=0; //用于进行循环的索引使用
    allPrice=0;
    allGoodsCount=0;  //把商品总数量设置为
    tempList.forEach((item){//进行循环，找出是否已经存在该商品
      //如果存在，数量进行+1操作
      if(item['goodsId']==cart.goodsId){
        tempList[ival]['count']=item['count']+1;
        cartList[ival].count=item['count']+1;

        isHave=true;
      }

      if(item['isCheck']){
        allPrice+= (cartList[ival].price* cartList[ival].count);
        allGoodsCount+= cartList[ival].count;
      }
      ival++;
    });
    //  如果没有，进行增加
    if(!isHave){
      allPrice+= (cart.count * cart.price);
      allGoodsCount+=cart.count;
      tempList.add(cart.toJson());
      cartList.add(cart);
    }
    //把字符串进行encode操作，
    cartString= json.encode(tempList).toString() ;
    print(cartString.toString());
    print("数据模型"+cartList.toString());

    // ignore: argument_type_not_assignable
    prefs.setString('cartInfo', cartString.toString());//进行持久化

    notifyListeners() ;
  }


  removeallcart() async {

    //初始化SharedPreferences
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    prefs.remove('cartInfo') ;  //获取持久化存储的值
    cartList = [];
    print("清空完成");
    notifyListeners() ;
  }


  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    cartString=prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    cartList=[];

    //判断得到的字符串是否有值，如果不判断会报错
    if(cartString==null){
      cartList=[];
    }else{
      List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
      allPrice=0;
      allGoodsCount=0;
      isAllCheck=true;

      tempList.forEach((item){
        if(item['isCheck']){
          allPrice+=(item['count']*item['price']);
          allGoodsCount+=item['count'];
        }
        else{
          isAllCheck=false;
        }
        cartList.add(new CartModel.fromJson(item));
      });

    }
    notifyListeners();
  }

  deleteOneGoods(String goodsId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

    int tempIndex =0;
    int delIndex=0;
    tempList.forEach((item){

      if(item['goodsId']==goodsId){
        delIndex=tempIndex;

      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    print('删除商品'+delIndex.toString());
    cartString= json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);//
    await getCartInfo();


  }

//改变选中状态 检索选中的商品改变check 重新放入存储中，在重新获取商品
  changeCheckState(CartModel cartItem) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');  //得到持久化的字符串
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast(); //声明临时List，用于循环，找到修改项的索引
    int tempIndex =0;  //循环使用索引
    int changeIndex=0; //需要修改的索引
    tempList.forEach((item){

      if(item['goodsId']==cartItem.goodsId){
        //找到索引进行复制
        changeIndex=tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex]=cartItem.toJson(); //把对象变成Map值
    cartString= json.encode(tempList).toString(); //变成字符串
    prefs.setString('cartInfo', cartString);//进行持久化
    await getCartInfo();  //重新读取列表

  }

  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    List<Map> newList=[]; //新建一个List，用于组成新的持久化数据。
    for(var item in tempList ){
      var newItem = item; //复制新的变量，因为Dart不让循环时修改原值
      newItem['isCheck']=isCheck; //改变选中状态
      newList.add(newItem);
    }

    cartString= json.encode(newList).toString();//形成字符串
    prefs.setString('cartInfo', cartString);//进行持久化
    await getCartInfo();

  }
//增加或者减少的方法  商品，增加或者减少
  addOrReduceAction(var cartItem, String todo )async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast(); //声明临时List，用于循环，找到修改项的索引
    int tempIndex =0;  //循环使用索引
    int changeIndex=0; //需要修改的索引
    tempList.forEach((item){

      if(item['goodsId']==cartItem.goodsId){
        //找到索引进行复制
        changeIndex=tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex]=cartItem.toJson(); //把对象变成Map值

      if (todo=='+'){
        tempList[changeIndex]['count']++;
      }else{
        if (tempList[changeIndex]['count'] == 0){
          tempList[changeIndex]['count'] = 0;
        }else {
          tempList[changeIndex]['count'] --;

        }
      }

    cartString= json.encode(tempList).toString();//形成字符串
    prefs.setString('cartInfo', cartString);//进行持久化
    await getCartInfo();
  }


}