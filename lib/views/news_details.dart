import 'package:basmicorona/helper/consts.dart';
import 'package:basmicorona/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:basmicorona/models/api_model.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatefulWidget {
  final Article article;

  NewsDetails(this.article);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 3,
                  ),
                  Image.network(widget.article.urlToImage),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.article.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "ditulis oleh ",
                            style: TextStyle(fontSize: 13.0),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            widget.article.author != null
                                ? widget.article.author + ", "
                                : "Anonymous" + ", ",
                            style: TextStyle(
                                fontSize: 13.0,
                                decoration: TextDecoration.underline),
                            textAlign: TextAlign.start,
                          ),
                          // Text(
                          //   new DateFormat.yMMMd()
                          //       .format(widget.article.publishedAt),
                          //   style: TextStyle(
                          //       fontSize: 13.0, fontStyle: FontStyle.italic),
                          // ),
                          SizedBox(width: 8),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.article.description,
                      style: TextStyle(fontSize: 19.0),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
