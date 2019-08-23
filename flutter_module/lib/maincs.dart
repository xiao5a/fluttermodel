import 'package:flutter/material.dart';
import './test/ConterModel.dart';
import 'package:provider/provider.dart';
import './test/FirstScreen.dart';
void main() {
  final counter = CounterModel();
  final textSize = 48;

  runApp(
    Provider<int>.value(
    value: textSize,
    child: ChangeNotifierProvider.value(
      value: counter,
      child: MyApp(),
    ),
  ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FirstScreen(),
    );
  }
}
