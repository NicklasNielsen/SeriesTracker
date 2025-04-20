import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../DataModels/series.dart';


abstract class DataRetriever {
  Future<Series> getSeriesInformation({String? id, String? title});
  Future<List<Series>> searchSeries({required String partName});

  String toQuery(Map<String, dynamic> obj) {
    obj.putIfAbsent('apiKey', () => 'c61fa8a6');
    final withoutNullValues = Map.fromEntries(obj.entries.where((prop) => prop.value != null));
    return withoutNullValues.entries.map((entry) => '${entry.key}=${entry.value}').join('&');
  }
}

class OmdbApi extends DataRetriever {
  @override
  Future<Series> getSeriesInformation({String? id, String? title}) async {
    if (id == null && title != null) {
      throw ErrorDescription('Either id or title is needed to search for a series.');
    }

    final params = {
      't': title,
      'i': id,
    };
    var res = await http.get(Uri.parse('http://www.omdbapi.com/?${toQuery(params)}'));
    var data = json.decode(res.body);
    return Series.fromJson(data);
  }

  @override
  Future<List<Series>> searchSeries({required String partName}) async {
    final params = {
      's': '$partName*',
      'type': 'series',
    };
    var res = await http.get(Uri.parse('http://www.omdbapi.com/?${toQuery(params)}'));
    var data = json.decode(res.body)['Search'] as List<dynamic>;

    final series = data.map((d) => Series.fromJson(d));
    return series.toList();
  }
}