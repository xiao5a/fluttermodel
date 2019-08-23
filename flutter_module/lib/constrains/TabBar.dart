
import 'package:flutter/material.dart';
class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage> with SingleTickerProviderStateMixin {

  TabController controller;//tab控制器
  int _currentIndex = 0; //选中下标

  List<String> _datas = new List();//tab集合
  List<String> _listDatas = new List();//内容集合

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void getHttp() async {
    try {
//      var response = await HttpUtil().get(Api.PROJECT);
//      Map userMap = json.decode(response.toString());
//      var projectEntity = new ProjectEntity.fromJson(userMap);

      setState(() {
        if (_datas.length != null) _datas = ["历史","语文","数学"];
        _currentIndex = 0;
      });

      getDetail();

      //初始化controller并添加监听
      controller = TabController(length: _datas.length, vsync: this);
      controller.addListener(() => _onTabChanged());

    } catch (e) {
      print(e);
    }
  }

  ///
  /// tab改变监听
  ///
  _onTabChanged() {
    if (controller.indexIsChanging) {
      if (this.mounted) {
        //赋值 并更新数据
        this.setState(() {
          _currentIndex = controller.index;
        });
        getDetail();
      }
    }
  }

  ///
  /// 根据tab下标获取数据
  ///
  void getDetail() async {
    try {
//      var data = {"cid": _datas[_currentIndex].id};
//      var response = await HttpUtil().get(Api.PROJECT_LIST, data: data);
//      Map userMap = json.decode(response.toString());
//      var projectListEntity = new ProjectListEntity.fromJson(userMap);

      setState(() {
        _listDatas = ["页面1","页面2"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _datas.length,
      child: new Scaffold(
        appBar: AppBar(
          title: Text("tabBar"),
          leading: IconButton(
        icon: new Image.asset("assets/images/nav_close.png"),
          onPressed: () {
            Navigator.maybePop(context);
          }
      ),
          bottom: new TabBar(
            
            controller: controller,//控制器
            labelColor: Colors.white, //选中的颜色
            labelStyle: TextStyle(fontSize: 16), //选中的样式
            unselectedLabelColor: Colors.black, //未选中的颜色
            unselectedLabelStyle: TextStyle(fontSize: 14), //未选中的样式
            indicatorColor: Colors.pink, //下划线颜色
            isScrollable: true, //是否可滑动
            //tab标签
            tabs: _datas.map((String choice) {
              return new Tab(
                text: choice,
              );
            }).toList(),
            //点击事件
            onTap: (int i) {
              print(i);
            },
          ),


        ),


        body: new TabBarView(
          controller: controller,
          children: [Text("77"),Text("88"),Text("数学")],
        ),
      ),
    );
  }

//  Widget getRow(int i) {
//    return new GestureDetector(
//      child: new Container(
//        alignment: Alignment.topLeft,
//        padding: EdgeInsets.all(10),
//        child: new Card(
//          elevation: 5,
//          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//          color: Colors.white,
//          child: Padding(
//            padding: EdgeInsets.all(10),
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                new Expanded(
//                  flex: 2,
//                  child: new Image.network(_listDatas[i].envelopePic),
//                ),
//                new Expanded(
//                  flex: 5,
//                  child: new Column(
//                    mainAxisSize: MainAxisSize.max,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      new Padding(
//                        padding: EdgeInsets.symmetric(horizontal: 10),
//                        child: new Text(
//                          _listDatas[i].title,
//                          style: TextStyle(
//                              fontSize: 16, fontWeight: FontWeight.bold),
//                          maxLines: 3,
//                          overflow: TextOverflow.ellipsis,
//                        ),
//                      ),
//                      new Padding(
//                        padding: EdgeInsets.all(10),
//                        child: new Text(
//                          _listDatas[i].desc,
//                          style:
//                          TextStyle(fontSize: 14, color: YColors.color_666),
//                          maxLines: 3,
//                          overflow: TextOverflow.ellipsis,
//                        ),
//                      ),
//                      new Container(
//                        alignment: Alignment.bottomLeft,
//                        child: Row(
//                          children: <Widget>[
//                            new Expanded(
//                              flex: 1,
//                              child: new Padding(
//                                padding: EdgeInsets.all(10),
//                                child: new Text(_listDatas[i].niceDate,
//                                    style: TextStyle(fontSize: 14)),
//                              ),
//                            ),
//                            new Padding(
//                              padding: EdgeInsets.all(10),
//                              child: new Text(
//                                _listDatas[i].author,
//                                style: TextStyle(fontSize: 14),
//                                textAlign: TextAlign.right,
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//      onTap: () {
//        //点击item跳转到详情
////        Navigator.push(
////          context,
////          new MaterialPageRoute(
////              builder: (context) => new ArticleDetail(
////                  title: _listDatas[i].title, url: _listDatas[i].link)),
////        );
//      },
//    );
//  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
