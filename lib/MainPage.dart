import 'package:flutter/material.dart';
import 'package:learningApp/SliverDetails.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TabController _controllerTab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerTab = TabController(length: 2, vsync: this);
    _controllerTab.addListener(() => {setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: !_keyboardIsVisible()
            ? FloatingActionButton(
                onPressed: () {
                  print('save');
                },
                child: Column(
                  children: [Text('save'), Icon(Icons.check)],
                ),
              )
            : Container(),
        body: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  snap: false,
                  elevation: 50,
                  backgroundColor: Colors.green,
                  collapsedHeight: MediaQuery.of(context).size.height * 0.25,
                  expandedHeight: MediaQuery.of(context).size.height * 0.25,
                  flexibleSpace: FlexibleSpaceBar(), // ProfileView()
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: SliverPersistentHeaderDelegateImpl(
                    color: Colors.white,
                    tabBar: tabBar(),
                  ),
                ),
              ];
            },
            body: TabBarView(controller: _controllerTab, children: [
              Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Hello'),
                      TextField(
                        onChanged: (String val) {
                          print('$val');
                        },
                      ),
                      TextButton(
                          onPressed: () {
                            print(_keyboardIsVisible());
                          },
                          child: Text('Check Jeybiard')),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [Text('Heloo')],
                  ),
                ),
              ),
            ])),
      ),
    );
  }

  Widget tabBar() {
    return TabBar(
      isScrollable: true,
      controller: _controllerTab,
      tabs: [
        Tab(text: 'Overview'),
        Tab(text: 'Resume'),
      ],
      indicatorColor: Colors.red,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.red,
    );
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
}
