enum FLBuglyLogLevel {
  silent,
  error,
  warn,
  info,
  debug,
  verbose,
}

class FLBuglyConfig extends Object {
  ///
  ///  SDK Debug信息开关, 默认关闭
  ///
  bool debugMode = false;

  ///
  ///  设置自定义渠道标识
  ///
  String? channel;

  ///
  ///  设置自定义版本号
  ///
  String? version;

  ///
  ///  设置自定义设备唯一标识
  ///
  String? deviceIdentifier;

  ///
  /// 控制自定义日志上报，默认值为FLBuglyLogLevelSilent，即关闭日志记录功能。
  /// 如果设置为FLBuglyLogLevelWarn，则在崩溃时会上报Warn、Error接口打印的日志
  ///
  FLBuglyLogLevel reportLogLevel = FLBuglyLogLevel.silent;

  ///
  ///  控制台日志上报开关，默认开启
  ///
  bool consolelogEnable = true;

  ///
  ///  设置自定义联网、crash上报域名
  ///
  String? crashServerUrl;

  /// 转json
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['debugMode'] = debugMode;
    json['channel'] = channel;
    json['version'] = version;
    json['deviceIdentifier'] = deviceIdentifier;
    json['reportLogLevel'] = reportLogLevel.index;
    json['consolelogEnable'] = consolelogEnable;
    json['crashServerUrl'] = crashServerUrl;
    return json;
  }
}
