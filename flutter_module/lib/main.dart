


import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter.dart';
import 'provide/child_category.dart';
import 'provide/category_goods_povider.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './application/application.dart';
import './provide/details_info_provide.dart';
import './provide/cartprovider.dart';
import './provide/currentIndex.dart';


void main() {

//  var counter =Counter();
//  var childCategory=ChildCategory();
//  var categoryGoodsListProvider=CategoryGoodsListProvider ();
//  var details_info_provide =Details_info_provide();
//  var catprovider = CartProvider();
//  var currentIndexProvider = CurrentIndexProvide();
//
//  var rooter = Router();//路由类
//  Routers.configureRoutes(rooter); //路由配置类 完成路由的注册
//   Application.router = rooter;//静态话路由配置
//  var providers  =Providers();
//  providers
//    ..provide(Provider<Counter>.value(counter))
//    ..provide(Provider<ChildCategory>.value(childCategory))
//    ..provide(Provider<CategoryGoodsListProvider>.value(categoryGoodsListProvider))
//    ..provide(Provider<Details_info_provide>.value(details_info_provide))
//    ..provide(Provider<CartProvider>.value(catprovider))
//    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvider))
//   ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
//        onGenerateRoute: Application.router.generator,
        title: '百年孤独',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}

