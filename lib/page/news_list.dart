// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tnews/model/ArticleModel.dart';
import 'package:tnews/services/NewServices.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  String selectedCategory = 'general';
  final List<String> categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  List<Articlemodel> listArticle = [];
  bool isLoader = true;
  String errorMessage = "";
  final Newservices newservices = Newservices();
  void fetchNews() async {
    try {
      List<Articlemodel> articles = await newservices.getNews(selectedCategory);
      setState(() {
        listArticle = articles;
        isLoader = false;
      });
    } catch (error) {
      isLoader = false;
      errorMessage = error.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
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
        actions: [
          DropdownButton(
            iconEnabledColor: Colors.teal,
            dropdownColor: Colors.teal[100],
              items: categories.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  selectedCategory = value;
                  fetchNews();
                }
              })
        ],
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
