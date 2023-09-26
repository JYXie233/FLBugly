#import "FlBuglyPlugin.h"
#import <Bugly/Bugly.h>
#import "BuglyConfig+FLExtension.h"



@implementation FlBuglyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"jacketxia/fl_bugly"
            binaryMessenger:[registrar messenger]];
  FlBuglyPlugin* instance = [[FlBuglyPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"report" isEqualToString:call.method]) {
      NSDictionary *argument = call.arguments;
      NSString *exception = argument[@"exception"];
      NSArray *stackTrace = [argument[@"stackTrace"] componentsSeparatedByString:@","];
      [Bugly reportExceptionWithCategory:5 name:@"Flutter Exception" reason:exception callStack:stackTrace extraInfo:@{} terminateApp:false];
      result(nil);
  }if ([@"startWithAppId" isEqualToString:call.method]){
      NSDictionary *arguments = call.arguments;
      NSString *iOSAppId = arguments[@"iOSAppId"];
      NSDictionary *configDic = NULLToNil(arguments[@"config"]);
      if (configDic){
          BuglyConfig *config = [BuglyConfig fl_jsonToModel:configDic];
          [Bugly startWithAppId:iOSAppId config:config];
      }else {
          [Bugly startWithAppId:iOSAppId];
      }
      result(nil);
  }if ([@"setUserIdentifier" isEqualToString:call.method]){
      NSString *userId = call.arguments;
      [Bugly setUserIdentifier:userId];
      result(nil);
  }if ([@"setUserValueAndKey" isEqualToString:call.method]){
      NSDictionary *arguments = call.arguments;
      NSString *key = arguments[@"key"];
      NSString *value = arguments[@"value"];
      [Bugly setUserValue:key forKey:value];
      result(nil);
  }if ([@"setTag" isEqualToString:call.method]){
      NSNumber *tag = call.arguments;
      [Bugly setTag:tag.unsignedIntegerValue];
      result(nil);
  }else {
    result(FlutterMethodNotImplemented);
  }
}

@end
