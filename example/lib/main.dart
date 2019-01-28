import 'package:flutter/material.dart';

import 'package:flutter_android_lifecycle/flutter_android_lifecycle.dart';
import 'package:flutter_branch_io_plugin/flutter_branch_io_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _data = '-';

  @override
  void initState() {
    super.initState();
    FlutterBranchIoPlugin.setupBranchIO();
    FlutterBranchIoPlugin.listenToDeepLinkStream().listen((string) {
      print("DEEPLINK $string");
      setState(() {
        this._data = string;
      });
    });
    FlutterAndroidLifecycle.listenToOnStartStream().listen((string) {
      print("ONSTART");
      FlutterBranchIoPlugin.setupBranchIO();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                      "LATEST DATA BRANCH $_data"
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
