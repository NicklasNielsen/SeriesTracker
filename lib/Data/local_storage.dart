import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:series_tracker/Data/list_notifier.dart';

import '../DataModels/series.dart';
import 'package:path_provider/path_provider.dart';

abstract class DataStorage {
  DataStorage(List<Series>? series): _series = ListNotifier(series ?? []);
  
  final ListNotifier<Series> _series;
  ValueListenable<List<Series>> get series => _series;
  Future<void> add({Series? item, Iterable<Series>? items});
  Future<void> remove(Series item);
  Future<void> update(Series item, {int? season, int? episode});
  Future<List<Series>> getAll({int Function(Series, Series)? sortFunc});
}

class LocalStorage extends DataStorage {
  LocalStorage([super.series]) {
    getAll();
  }
  
  Future<void> saveToFile() async {
    final file = await _localFile;
    try {
      final test = json.encode(_series.value);
      await file.writeAsString(test);  
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchFromFile() async {
    try{
      final file = await _localFile;   
      String content = await file.readAsString();

      List<dynamic> decoded = jsonDecode(content);
      _series.value = decoded.map((s) => Series.fromJson(s)).toList();
    }
    catch (e){
      print(e);
    }
  }

  Future<File> get _localFile async {
    var path = (await getApplicationDocumentsDirectory()).path;
    return File('$path/series.txt');
  }

  @override
  Future<void> add({Series? item, Iterable<Series>? items}) async {
    if (item != null) {
      _series.add(item);
      await saveToFile();
    } else if (items != null) {
      _series.addAll(items);
      await saveToFile();
    }
  }

  @override
  Future<void> remove(Series item) async {
    _series.remove(item);
    await saveToFile();
  }

  @override
  Future<void> update(Series item, {int? season, int? episode}) async {
    var index = series.value.indexWhere((x) => x.title == item.title);
    _series.value[index].season.value = season ?? _series.value[index].season.value;
    _series.value[index].episode.value = episode ?? _series.value[index].episode.value;
    await saveToFile();
  }

  @override
  Future<List<Series>> getAll({int Function(Series, Series)? sortFunc}) async {
    if (_series.value.isEmpty) {
      await fetchFromFile();
    }

    _series.value.sort(sortFunc);
    return _series.value;
  }
}