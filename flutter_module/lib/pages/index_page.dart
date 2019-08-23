import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/currentIndex.dart';
import '../WeChatNativeDemo.dart';
import '../service/native.dart';

 class IndexPage extends StatefulWidget {
   @override
   _IndexPageState createState() => _IndexPageState();
 }

 class _IndexPageState extends State<IndexPage> {

   final List<BottomNavigationBarItem> bottomBars = [
     BottomNavigationBarItem(
         icon: Icon(CupertinoIcons.home),
         title: Text("首页")
     ),
     BottomNavigationBarItem(
         icon: Icon(CupertinoIcons.shopping_cart),
         title: Text("购物车")
     ),
     BottomNavigationBarItem(
         icon: Icon(CupertinoIcons.search),
         title: Text("分类")
     ),

     BottomNavigationBarItem(
         icon: Icon(CupertinoIcons.profile_circled),
         title: Text("会员中心")
     ),
   ] ;
   final List<Widget> barPages = [
     HomePage(),
     CartPage(),
     CategoryPage(),
     memberPage()
   ];

   int currentpageIndex  = 0;
   var currentpage  ;

   @override
   void initState() {
    super.initState();
    currentpage = barPages[currentpageIndex];
  }
   @override
   Widget build(BuildContext context) {
     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
     return Scaffold(
       backgroundColor: Color.fromARGB(255, 255, 254, 1),
       bottomNavigationBar:BottomNavigationBar(
           type: BottomNavigationBarType.fixed,
           currentIndex: currentpageIndex,
           items: bottomBars,
           onTap:(index){
             setState(() {
               currentpageIndex = index ;
               currentpage = barPages[currentpageIndex];
             });

           } ,
       )
       ,
       body:
       IndexedStack(index: currentpageIndex,children: barPages,)
     );
   }

 }
//class IndexPage extends StatelessWidget {
//  final List<BottomNavigationBarItem> bottomBars = [
//    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.search), title: Text("分类")),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.profile_circled), title: Text("会员中心")),
//  ];
//
//  final List<Widget> barPages = [
////    WeChatNativeDemo(),
//    HomePage(),
//    CartPage(),
//    CategoryPage(),
//    memberPage()
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//
//    return Provide<CurrentIndexProvide>(builder: (context, child, val) {
//      int currentIndex= Provide.value<CurrentIndexProvide>(context).currentIndex;
//
//      return Scaffold(
//          backgroundColor: Color.fromARGB(255, 255, 254, 1),
//          bottomNavigationBar: BottomNavigationBar(
//            type: BottomNavigationBarType.fixed,
//            currentIndex: currentIndex,
//            items: bottomBars,
//            onTap: (index) {
//             Provide.value<CurrentIndexProvide>(context).changeIndex(index);
//            },
//          ),
//          body: IndexedStack(
//            index: currentIndex,
//            children: barPages,
//          ));
//    });
//  }
//}
