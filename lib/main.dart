import 'package:flutter/material.dart';

import './movie/list.dart';

// 入口函数
void main() {
  runApp(const MyApp());
}

// 无状态控件 有状态控件
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 每个项目最外层 必须有 MaterialApp
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      // 通过 home指定首页
      home: const MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('电影列表'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.search, color: Colors.white))
            ],
          ),
          drawer: Drawer(
            child: ListView(padding: const EdgeInsets.all(0), children: const [
              UserAccountsDrawerHeader(
                accountName: Text('张三啊'),
                accountEmail: Text('abc@qq.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2F5c%2F25%2F22%2F5c252287d2b39d9eac7dcad60d7a3b0e.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1657856747&t=46f77ce49c54de20d77721e9030e35a9'),
                ),
                // 美化当前控件的
                decoration: BoxDecoration(
                    // 背景图片
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://c-ssl.duitang.com/uploads/blog/202105/17/20210517002731_98153.jpg'))),
              ),
              ListTile(title: Text('用户反馈'), trailing: Icon(Icons.feedback)),
              ListTile(title: Text('系统设置'), trailing: Icon(Icons.settings)),
              ListTile(title: Text('我要发布'), trailing: Icon(Icons.send)),
              // 分割线控件
              Divider(
                color: Colors.grey,
                height: 10,
                thickness: 1,
                indent: 15.0,
                endIndent: 15.0,
              ),
              ListTile(title: Text('注销'), trailing: Icon(Icons.exit_to_app)),
            ]),
          ),
          bottomNavigationBar: Container(
              // 美化当前的Container
              decoration: const BoxDecoration(color: Colors.black),
              // 一般bottomNavigationBar高度都是50
              height: 50,
              child: const TabBar(
                  labelStyle: TextStyle(height: 0, fontSize: 10),
                  tabs: [
                    Tab(
                      icon: Icon(Icons.movie_filter),
                      text: '正在热映',
                    ),
                    Tab(
                      icon: Icon(Icons.movie_creation),
                      text: '即将上映',
                    ),
                    Tab(
                      icon: Icon(Icons.movie_filter),
                      text: 'Top250',
                    ),
                  ])),
          body: const TabBarView(
            children: [
              MovieList(movieType: 'in_theaters'),
              MovieList(movieType: 'coming_soon'),
              MovieList(movieType: 'top250'),
            ],
          ),
        ));
  }
}
