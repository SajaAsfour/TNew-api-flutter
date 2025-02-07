// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tnews/model/ArticleModel.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<Articlemodel> listArticle = [];
  bool isLoader = true;
  String errorMessage = "";

  void getNews() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
          "https://newsapi.org/v2/everything?q=tesla&from=2025-01-07&sortBy=publishedAt&apiKey=bcce431eca9545368c70c5c49f532b15");
      Map<String, dynamic> data = response.data;
      List<dynamic> articles = data["articles"];
      List<Articlemodel> articlesList = [];
      for (var item in articles) {
        Articlemodel article = Articlemodel(
          title: item["title"],
          desc: item["description"],
          image: item["urlToImage"],
        );
        articlesList.add(article);
      }
      setState(() {
        listArticle = articlesList;
        isLoader = false;
      });
    } catch (err) {
      setState(() {
        isLoader = false;
        errorMessage = "Server Error ....";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "T-News",
          style: TextStyle(
            fontFamily: "Times New Roman",
          ),
        ),
        centerTitle: true,
      ),
      body: isLoader
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.teal[200],
            ))
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 20,
                        color: Colors.red),
                  ),
                )
              : ListView.builder(
                  itemCount: listArticle.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.teal[100],
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          listArticle[index].title,
                          style: TextStyle(fontFamily: "Times New Roman"),
                        ),
                      ),
                    );
                  }),
    );
  }
}
