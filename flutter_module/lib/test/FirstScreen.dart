import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ConterModel.dart';
import 'SecondPage.dart';
import '../constrains/SamplePage.dart';
import '../constrains/Column.dart';
import '../constrains/TabBar.dart';
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    return Scaffold(
      appBar: AppBar(
        title: Text('练习ui&布局'),
      ),
      body: Center(
      child: new Column(
        // Column is also layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug paint" (press "p" in the console where you ran
        // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
        // window in IntelliJ) to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Text(
            'Value: ${_counter.value}',
            style: TextStyle(fontSize: textSize),
          ),
          new Text(
            'You have pushed the button this many times:',
          ),
          new Text(
            '$_counter',
            style: Theme.of(context).textTheme.display1,
          ),
          new GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new SamplePage()));
            },
            child: new Text(
              "点击我跳转到Sample页面",
              style: new TextStyle(fontSize: 26.0, color: Colors.red),
            ),
          ),

          new GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new LYColumn()));
            },
            child: new Text(
              "点击我跳转到Column页面",
              style: new TextStyle(fontSize: 26.0, color: Colors.red),
            ),
          ),

          new GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ProjectPage()));
            },
            child: new Text(
              "点击我跳转到Column页面",
              style: new TextStyle(fontSize: 26.0, color: Colors.red),
            ),
          ),
        ],
      ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SecondPage())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
