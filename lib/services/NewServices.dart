// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:tnews/model/ArticleModel.dart';

class Newservices {
  final Dio dio = Dio();
  final String baseUrl = "https://newsapi.org/v2/everything";
  final String apiKey = "bcce431eca9545368c70c5c49f532b15";

  Future<List<Articlemodel>> getNews(category) async {
    try {
      Response response = await dio.get(
          "${baseUrl}?q=${category}&from=2025-01-07&sortBy=publishedAt&apiKey=${apiKey}");
      List<dynamic> articles = response.data["articles"];
      return articles.map((item) {
        return Articlemodel.fromJson(item);
      }).toList();
    } catch (error) {
      throw new Exception(error);
    }
  }
}
