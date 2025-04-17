import 'package:aim/components/fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    /*
      TODO: 开始处理关于PageView的内容了，需要写侧边栏，但是目前还没有想好该怎么去编写，当然不是很难，明天进行一个大修改就好了
     */
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: Fab(),
      body: PageView(
        children: [
          Center(
            child: Text(
              '点击按钮创建第一个组吧',
            ),
          )
        ],
      ),
    );
  }
}
