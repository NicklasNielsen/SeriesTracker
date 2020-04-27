import 'dart:io';
import 'dart:convert';
import '../DataModels/series.dart';
import 'package:path_provider/path_provider.dart';

class DataStorage {
  static List<Series> series = new List<Series>();

  static Future<void> saveToFile() async {
    final file = await _localFile;
    try {
      await file.writeAsString(json.encode(series));  
    } catch (e) {
      print(e);
    }
    
  }

  static Future<File> get _localFile async {
    var path = (await getApplicationDocumentsDirectory()).path;
    return File('$path/series.txt');
  }

  static Future<void> add(Series item) async {
    series.add(item);
    await saveToFile();
  }

  static Future<void> remove(Series item) async {
    series.remove(item);
    await saveToFile();
  }

  static Future<void> update(Series item, int season, int episode) async {
    var index = series.indexWhere((x) => x.title == item.title);
    series[index].season = season != 0 ? season : series[index].season;
    series[index].episode = episode != 0 ? episode : series[index].episode;
    await saveToFile();
  }

  static Future<List<Series>> getSeries({int Function(Series, Series) sortFunc}) async {
    try{
      final file = await _localFile;      
      String content = await file.readAsString();

      var jsonData = json.decode(content);
      series = (jsonData as List).map((seriesJson) => Series.fromJson(seriesJson)).toList();
    }
    catch (e){
      print(e);
    }

    series.sort(sortFunc); //(a, b) => a.title.compareTo(b.title)
    return series;
  }
}