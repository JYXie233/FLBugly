import 'package:flutter/services.dart';

/// An implementation of [MethodChannelFlBugly] that uses method channels.
class MethodChannelFlBugly extends Object {
  /// The method channel used to interact with the native platform.

  final _methodChannel = const MethodChannel('jacketxia/fl_bugly');

  Future<T?> send<T>(String method, [dynamic arguments]) async {
    return _methodChannel.invokeMethod<T>(method, arguments);
  }
}
