import 'package:flutter/foundation.dart';
import 'fl_bugly_method_channel.dart';

abstract class FlBuglyInterface {
  static final MethodChannelFlBugly _instance = MethodChannelFlBugly();

  /// 上报错误
  static void report(FlutterErrorDetails details) {
    final errorMsg = {
      "exception": details.exceptionAsString(),
      "stackTrace": details.stack.toString(),
    };
    _instance.send('report', errorMsg);
  }

  /// 传输给原生
  static void send(String method, dynamic arguments) {
    _instance.send(method, arguments);
  }
}
