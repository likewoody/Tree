import 'package:flutter/material.dart';
import 'package:td_app/view/tabbar/historyPage.dart';
import 'package:td_app/view/tabbar/settingPage.dart';

class CommonTabbar extends StatefulWidget {
  const CommonTabbar({super.key});

  @override
  State<CommonTabbar> createState() => _CommonTabbarState();
}

class _CommonTabbarState extends State<CommonTabbar> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  // 앱이 종료될 때 tabbar 지우기
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("탭바입니다."),
      // ),
      body: TabBarView(
        controller: tabController,
        children: const [
          History(),
          Setting()
        ]
      ),

      bottomNavigationBar: Container(
        color: Colors.green,
        height: 90,
        child: TabBar(
          controller: tabController,
          labelColor: Colors.amber,
          indicatorColor: Colors.red,
          indicatorWeight: 5,
          tabs: const [
            Tab(  // 1번째 탭에 대한 정보
              icon: Icon(Icons.list_alt),
              text: 'History',
            ), 
            Tab(  // 2번째 탭에 대한 정보
              icon: Icon(Icons.settings),
              text: 'Set',
            )
        ]),
      ),
    );
  }
}