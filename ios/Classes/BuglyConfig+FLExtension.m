//
//  BuglyConfig+FLExtension.m
//  fl_bugly
//
//  Created by JacketXia on 2023/5/15.
//

#import "BuglyConfig+FLExtension.h"

@implementation BuglyConfig (FLExtension)

+ (instancetype)fl_jsonToModel:(NSDictionary *)json {
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.debugMode = [NULLToNil(json[@"debugMode"]) boolValue];
    config.channel = NULLToNil(json[@"channel"]);
    config.version = NULLToNil(json[@"version"]);
    config.deviceIdentifier = NULLToNil(json[@"deviceIdentifier"]);
    config.reportLogLevel = [NULLToNil(json[@"reportLogLevel"]) intValue];
    config.consolelogEnable = [NULLToNil(json[@"consolelogEnable"]) boolValue];
    config.crashServerUrl = NULLToNil(json[@"crashServerUrl"]);
    return config;
}

@end
