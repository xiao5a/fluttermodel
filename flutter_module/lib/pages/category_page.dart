import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../model/categorygoodslist.dart';
import '../provide/category_goods_povider.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../application/application.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNva(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNva extends StatefulWidget {
  @override
  _LeftCategoryNvaState createState() => _LeftCategoryNvaState();
}

class _LeftCategoryNvaState extends State<LeftCategoryNva> {
  List list = [];
  var listIndex = 0; //索引
  @override
  void initState() {
    _getCategory();
    _getCategoryGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftwidget(index);
        },
      ),
    );
  }

  Widget _leftwidget(int index) {
    bool isClick=false;
    isClick=(index==listIndex)?true:false;
    return InkWell(
        onTap: () {
          setState(() {
            listIndex=index;
          });

          var childList = list[index].bxMallSubDto;
          Provide.value<ChildCategory>(context).getChildCategory(childList,list[index].mallCategoryId);
          _getCategoryGoodsList(categoryId:list[index].mallCategoryId);
        },
        child: Container(
          height: ScreenUtil().setHeight(100),
          padding: EdgeInsets.only(left: 10, top: 20),
          decoration: BoxDecoration(
              color: isClick?Colors.black26:Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: Text(
            list[index].mallCategoryName,
            style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          ),
        ));
  }

  void _getCategory() async {
    await getRequest('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryBigModel category = CategoryBigModel.fromJson(data);
      print("分类数据" + category.data.toString());
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory( list[0].bxMallSubDto,list[0].mallCategoryId);
    });
  }

  void _getCategoryGoodsList({categoryId}) async{
    var data={
      'categoryId':categoryId==null?'4':categoryId,
      'categorySubId':'',
      'page':1
    };
    print('data----------'+data.toString());
    await getRequest('getMallGoods',formData: data).then((val){
      var data= json.decode(val.toString()) ;
      CategoryGoodsListModel categoryGoodsListModel = CategoryGoodsListModel.fromJson(data);

      Provide.value<CategoryGoodsListProvider>(context).getCategoryGoodsList(categoryGoodsListModel.goodsListData);
    }
    );
  }
}

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Provide<ChildCategory>(builder: (context, child, childCategory) {
      return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(index,childCategory.childCategoryList[index]);
            },
          ));
    }));
  }

  Widget _rightInkWell(index,BxMallSubDto item) {
    print('item'+item.mallSubName);

    bool isontaped = false ;
    isontaped = (index==Provide.value<ChildCategory>(context).tindex)?true:false;
    return InkWell(
      onTap: () {
        print('index'+index.toString());
        Provide.value<ChildCategory>(context).changeIndex(index,item.mallSubId);
        _getsubCategoryGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isontaped?Colors.pink:Colors.black,
          ),
        ),
      ),
    );
  }

  void _getsubCategoryGoodsList(categorySubId) async{
    var data={
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId=='00'?'': categorySubId,
      'page':1
    };
    print('data----------'+data.toString());
    await getRequest('getMallGoods',formData: data).then((val){
      print('小类切换商品返回-----'+val.toString());
      var data= json.decode(val.toString()) ;
      CategoryGoodsListModel categoryGoodsListModel = CategoryGoodsListModel.fromJson(data);
       if(categoryGoodsListModel.goodsListData==null){
         Provide.value<CategoryGoodsListProvider>(context).getCategoryGoodsList([]);
       }else {
         Provide.value<CategoryGoodsListProvider>(context).getCategoryGoodsList(categoryGoodsListModel.goodsListData);

       }

    }
    );
  }
}
class CategoryGoodList extends StatefulWidget {
  @override
  _CategoryGoodListState createState() => _CategoryGoodListState();
}

class _CategoryGoodListState extends State<CategoryGoodList> {
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvider>(builder: (context, child, categoryGoodsListProvider) {

      try{
        if(Provide.value<ChildCategory>(context).page==1){
          scrollController.jumpTo(0.0);
        }
      }catch(e){
        print('进入页面第一次初始化：${e}');
      }

      if(categoryGoodsListProvider.categoryGoodsList.length>0){
        return
          Expanded(
            child: Container(
                width: ScreenUtil().setWidth(570) ,
                height: ScreenUtil().setHeight(1050),
                child:
                  EasyRefresh(
                  refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载....'),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: categoryGoodsListProvider.categoryGoodsList.length,
                      itemBuilder: (context,index){
                        return _ListWidget(categoryGoodsListProvider.categoryGoodsList,index);
                      },
                  ),
                    loadMore: () async {
                      _loadMoreGoodsList();
                      print('没有更多了.......');
                      Fluttertoast.showToast(
                          msg: "已经到底了",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.pink,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                    },
                )
            ),

          );
      }else{
        return Container(
          margin: EdgeInsets.only(top: 10.0),

          child: Text('暂时没有数据！'),
        );
        
      }
      

    });


  }
  void _loadMoreGoodsList() async{
    Provide.value<ChildCategory>(context).addPage();
    var data={
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).subcategoryId,
      'page':Provide.value<ChildCategory>(context).page
    };
    print('data----------'+data.toString());
    await getRequest('getMallGoods',formData: data).then((val){
      print('小类切换商品返回-----'+val.toString());
      var data= json.decode(val.toString()) ;
      CategoryGoodsListModel categoryGoodsListModel = CategoryGoodsListModel.fromJson(data);
      if(categoryGoodsListModel.goodsListData==null){
        Provide.value<ChildCategory>(context).getNoMoreText('没有更多了');
      }else {
        Provide.value<CategoryGoodsListProvider>(context).moreGoodsList(categoryGoodsListModel.goodsListData);

      }

    }
    );
  }
  Widget _goodsImage(newlist,index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newlist[index].image),
    );


  }
  Widget _goodsName(newlist,index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newlist[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );


  }
  Widget _goodsPrice(newlist,index){
    return  Container(
        margin: EdgeInsets.only(top:20.0),
        width: ScreenUtil().setWidth(370),
        child:Row(
            children: <Widget>[
              Text(
                '价格:￥${newlist[index].presentPrice}',
                style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
              Text(
                '￥${newlist[index].oriPrice}',
                style: TextStyle(
                    color: Colors.black26,
                    decoration: TextDecoration.lineThrough
                ),
              )
            ]
        )
    );
  }
  Widget _ListWidget(newlist,int index){
    return InkWell(
        onTap: (){
          Application.router.navigateTo(context, '/detail?id=${newlist[index].goodsId}');

        },
        child: Container(
          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0,color: Colors.black12)
              )
          ),
          child: Row(
            children: <Widget>[
              _goodsImage(newlist,index)
              ,
              Column(
                children: <Widget>[
                  _goodsName(newlist,index),
                  _goodsPrice(newlist,index)
                ],
              )
            ],
          ),
        )
    );
  }


}
