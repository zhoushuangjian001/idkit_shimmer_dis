import 'package:flutter/material.dart';
import 'package:idkit_shimmer/idkit_shimmer.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FPage(),
    );
  }
}

class FPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("闪烁组件测试"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              IDKitShimmer.linearBuild(
                child: Text(
                  "我是一只大鲨鱼",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                baseColor: Colors.red,
                highlightColor: Colors.orange,
                loop: 10,
              ),
              IDKitShimmer.linearBuild(
                child: Icon(
                  Icons.ac_unit_sharp,
                  size: 200,
                ),
                baseColor: Colors.red,
                highlightColor: Colors.orange,
                direction: Direction.btt,
              )
            ],
          ),
        ),
      ),
    );
  }
}
