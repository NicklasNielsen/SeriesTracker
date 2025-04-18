import 'package:http/http.dart' as http;
import 'dart:convert';
import '../DataModels/series.dart';


class DataRetriever {
    static Future<Series> getSeriesInformation(String title) async {
    var res = await http.get(Uri.parse("http://www.omdbapi.com/?apikey=c61fa8a6&t=$title"));
    var data = json.decode(res.body);
    return Series.fromJson(data);
  }

  static Future<List<Series>> searchSeries(String param) async {
    var res = await http.get(Uri.parse("http://www.omdbapi.com/?apikey=c61fa8a6&s=$param*&type=series"));
    var data = json.decode(res.body)["Search"];

    final series = (data as List<dynamic>).map((e) => Series(title: e['Title'], imageUrl: e['Poster']));
    return series.toList();
  }
}