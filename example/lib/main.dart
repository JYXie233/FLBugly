/*
 * @Author: Jacket Xia
 * @Date: 2023-05-12 15:42:51
 * @LastEditors: Jacket Xia
 * @LastEditTime: 2023-05-15 11:51:50
 * @Description: 请填写简介
 */
import 'package:fl_bugly/fl_bugly.dart';
import 'package:flutter/material.dart';

void main() {
  FlBugly.catchedException(
    () {
      runApp(const MyApp());
    },
    debugUpload: true,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FLBuglyConfig config = FLBuglyConfig();
    config.debugMode = true;
    config.channel = 'channel';
    config.version = '1.0.0';
    config.deviceIdentifier = 'id';
    config.reportLogLevel = FLBuglyLogLevel.info;
    config.consolelogEnable = true;
    config.crashServerUrl = 'https://www/baidu.com';

    FlBugly.startWithAppId(iOSAppId: 'ios', andriodAppId: '安卓', config: config);
    FlBugly.setTag(1);
    FlBugly.setUserIdentifier('userId');
    FlBugly.setUserKeyAndValue('key', 'value');
  }

  @override
  Widget build(BuildContext context) {
    String a = 12123131 as String;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
