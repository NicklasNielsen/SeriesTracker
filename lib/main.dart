import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:series_tracker/Screens/series_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'Series Tracker';

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoApp(
        title: title,
        home: CupertinoPageScaffold(child: SeriesList()),
        theme: CupertinoThemeData(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
      );
    }

    return MaterialApp(
      title: title,
      theme: ThemeData.dark(),
      home: Scaffold(body: SeriesList()),
      debugShowCheckedModeBanner: false,
    );
  }
}