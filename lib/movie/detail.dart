import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key, required this.id, required this.title})
      : super(key: key);

  final String id;

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailState();
  }
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), centerTitle: true),
        body: Text('电影名为${widget.title}'));
  }
}
