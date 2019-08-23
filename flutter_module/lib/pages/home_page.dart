import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '../config/service_url.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../application/application.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textctl = new TextEditingController();
  String showText = "百年孤独";
  int page = 1;
  List<Map> HotGoodsList = [];

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("百年孤独"),
        ),
        body: Container(
          child: FutureBuilder(
              future: getHomePageContent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = json.decode(snapshot.data.toString());
                  List<Map> swiperDataList =
                      (data['data']['slides'] as List).cast(); // 顶部轮播组件数
                  List<Map> navigatorList =
                      (data['data']['category'] as List).cast(); //类别列表
                  String advertesPicture =
                      data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
                  String leaderImage =
                      data['data']['shopInfo']['leaderImage']; //店长图片
                  String leaderPhone =
                      data['data']['shopInfo']['leaderPhone']; //店长电话
                  List<Map> recommendList =
                      (data['data']['recommend'] as List).cast(); // 商品推荐
                  String floortitle =
                      data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的
                  List<Map> floor1 =
                      (data['data']['floor1'] as List).cast(); //楼层1商品和图片
                  String floortitle2 =
                      data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的
                  List<Map> floor2 =
                      (data['data']['floor2'] as List).cast(); //楼层1
                  String floortitle3 =
                      data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的
                  List<Map> floor3 =
                      (data['data']['floor3'] as List).cast(); //楼层1
                  return EasyRefresh(
                    refreshFooter: ClassicsFooter(
                        key: _footerKey,
                        bgColor: Colors.white,
                        textColor: Colors.pink,
                        moreInfoColor: Colors.pink,
                        showMore: true,
                        noMoreText: '',
                        moreInfo: '加载中',
                        loadReadyText: '上拉加载....'),
                    child: ListView(
                      children: <Widget>[
                        SwiperDiy(swiperDataList: swiperDataList),
                        //页面顶部轮播组件
                        TopNavigator(navigatorList: navigatorList),
                        //导航组件
                        AdBanner(advertesPicture: advertesPicture),
                        LeaderPhone(
                            leaderImage: leaderImage, leaderPhone: leaderPhone),
                        //广告组件
                        Recommend(recommendList: recommendList),
                        FloorTitle(floortitle: floortitle),
                        FloorContent(goods: floor1),
                        FloorTitle(floortitle: floortitle2),
                        FloorContent(goods: floor2),
                        FloorTitle(floortitle: floortitle3),
                        FloorContent(goods: floor3),
                        _hotGoodsWiget(),
                      ],
                    ),
                    loadMore: () async {
                      await _getHotGoods();
                    },
                  );
                } else {
                  return Center(
                    child: Text('加载中'),
                  );
                }
              }),
        ),
      ),
    );
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型............');
    if (textctl.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('类型不能为空')));
    }
  }

  void _getHotGoods() {
    var formdata = {'formData': page};
    getRequest('homePageBelowConten', formData: formdata).then((val) {
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        HotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  Widget Hottitle = Container(
    child: Text('火爆专区'),
    width: ScreenUtil().setWidth(370),
  );

  Widget _wrapList() {
    if (HotGoodsList.length > 0) {
      List<Widget> HotGoodsListWiget = HotGoodsList.map((val) {
        return InkWell(
            onTap: () {
              print('点击了火爆商品');
              Application.router.navigateTo(context, '/detail?id=${val['goodsId']}');
            },
            child: Container(
              width: ScreenUtil().setWidth(372),
              color: Colors.white,
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 3.0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    val['image'],
                    width: ScreenUtil().setWidth(375),
                  ),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
            ));
      }).toList();
      return Wrap(
        children: HotGoodsListWiget,
        spacing: 2,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoodsWiget() {
    return Column(
      children: <Widget>[
        Hottitle,
        _wrapList(),
      ],
    );
  }
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {

          return InkWell(
            onTap: (){
              print('导航栏点击');

              Application.router.navigateTo(context, '/detail?id=${swiperDataList[index]['goodsId']}');

            },
            child: Image.network("${swiperDataList[index]['image']}",
                fit: BoxFit.fill),
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航${item['goodsId']}');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),//禁止滚动
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String advertesPicture;

  AdBanner({Key key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}

class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; //店长电话
  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommedList()],
      ),
    );
  }

//推荐商品标题
  Widget _titleWidget() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
        child: Text('商品推荐', style: TextStyle(color: Colors.pink)));
  }

  Widget _recommedList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(context,index);
        },
      ),
    );
  }

  Widget _item( BuildContext context,index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/detail?id=${recommendList[index]['goodsId']}');


      },
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class FloorTitle extends StatelessWidget {
  final String floortitle;

  FloorTitle({Key key, this.floortitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(floortitle),
    );
  }
}

class FloorContent extends StatelessWidget {
  final List goods;

  FloorContent({Key key, this.goods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _FirstFloor(context),
        _OtherFloor(context),
      ],
    );
  }

  Widget _FirstFloor(BuildContext context) {
    return Row(
      children: <Widget>[
        _item(context,0),
        Column(
          children: <Widget>[
            _item(context,2),
            _item(context,3),
          ],
        ),
      ],
    );
  }

  Widget _OtherFloor(BuildContext context) {
    return Row(
      children: <Widget>[
        _item(context,3),
        _item(context,4),
      ],
    );
  }

  Widget _item(BuildContext context,index) {
    return Container(
        width: ScreenUtil().setWidth(375),
        child: InkWell(
          onTap: () {
            print('点击了' + index.toString() + '商品');
            Application.router.navigateTo(context, '/detail?id=${goods[index]['goodsId']}');

          },
          child: Image.network(goods[index]['image']),
        ));
  }
}

class HotGoodsList extends StatefulWidget {
  @override
  _HotGoodsListState createState() => _HotGoodsListState();
}

class _HotGoodsListState extends State<HotGoodsList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
