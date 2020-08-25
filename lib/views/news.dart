import 'dart:async';
import 'dart:convert';
import 'package:basmicorona/helper/consts.dart';
import 'package:basmicorona/models/api_model.dart';
import 'package:basmicorona/services/api_services.dart';
import 'package:basmicorona/views/news_details.dart';
import 'package:basmicorona/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  Future<List<Article>> futureNews;
  @override
  void initState() {
    super.initState();
    futureNews = getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: FutureBuilder(
          future: futureNews,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }

  void _onTapItem(BuildContext context, Article article) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NewsDetails(article)));
  }

  Widget listViewWidget(List<Article> article) {
    return Container(
      child: ListView.builder(
          itemCount: 20,
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, position) {
            return Card(
              child: Container(
                height: 130.0,
                width: 120.0,
                child: Center(
                  child: ListTile(
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        article[position].author != null
                            ? '${article[position].author}'
                            : 'Anonymous',
                      ),
                    ),
                    title: Text(
                      '${article[position].title}',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Container(
                      height: 100.0,
                      width: 100.0,
                      child: article[position].urlToImage == null
                          ? Image.asset(
                              'images/no_image_available.png',
                              height: 100,
                              width: 100,
                            )
                          : Image.network(
                              '${article[position].urlToImage}',
                              height: 100,
                              width: 100,
                            ),
                    ),
                    onTap: () => _onTapItem(context, article[position]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
