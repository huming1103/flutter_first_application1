import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './detail.dart';

Dio dio = Dio();

// StatefulWidget 有状态控件
class MovieList extends StatefulWidget {
  const MovieList({Key? key, required this.movieType}) : super(key: key);

  // 电影类型
  final String movieType;

  @override
  _MovieListState createState() {
    return _MovieListState();
  }
}

// 有状态控件，必须结合一个状态管理类，来进行实现
class _MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin {
  int pageSize = 10;

  int offset = 0;

  var mList = [];

  int total = 0;

  // 实现菜单切换时，保存目前下拉条进度，配合 with AutomaticKeepAliveClientMixin 使用
  @override
  bool get wantKeepAlive => true;

  // 控件被创建的时候会执行initState
  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mList.length,
        itemBuilder: (BuildContext ctx, int i) {
          var item = mList[i];
          return GestureDetector(
            // 点击 GestureDetector 的child任何一个元素，都会触发onTab
            onTap: () {
              // 跳转到详情
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext ctx) {
                return MovieDetail(id: item['id'], title: item['title']);
              }));
            },
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.black26))),
              child: Row(
                children: [
                  Image.network(
                    item['images']['small'],
                    width: 130,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 20),
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('电影名称：${item['title']}'),
                          Text('上映年份：${item['year']}年'),
                          Text('电影类型：${item['genres'].join(' ')}'),
                          Text('豆瓣评分：${item['rating']['average']}分'),
                          Text('主要演员：${item['title']}')
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  // 获取电影数据
  getMovieList() async {
    var response = await dio.get(
        'http://www.liulongbin.top:3005/api/v2/movie/${widget.movieType}?start=$offset&count=$pageSize');
    var result = response.data;

    // 只要为私有数据赋值，都需要把赋值的操作，放到setState函数中，否则页面不会更新
    setState(() {
      // 通过dio返回的数据，必须通过[]来访问数据
      mList = result['subjects'];
    });
  }
}
