import 'package:http/http.dart' as http;
import 'dart:convert';
import '../DataModels/series.dart';


class DataRetriever {
    static Future<Series> getSeriesInformation(String title) async {
    var res = await http.get("http://www.omdbapi.com/?apikey=c61fa8a6&t=$title");
    var data = json.decode(res.body);
    return Series.fromJson(data);
  }

  static Future<List<dynamic>> searchSeries(String param) async {
    var res = await http.get("http://www.omdbapi.com/?apikey=c61fa8a6&s=$param*&type=series");
    var data = json.decode(res.body);
    
    return data["Search"];
  }
}