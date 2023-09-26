//
//  BuglyConfig+FLExtension.h
//  fl_bugly
//
//  Created by JacketXia on 2023/5/15.
//

#import <Bugly/Bugly.h>

NS_ASSUME_NONNULL_BEGIN

#if !defined(NULLToNil)
#define NULLToNil(object) ((!object || [object isKindOfClass:[NSNull class]]) ? nil : object)
#endif

@interface BuglyConfig (FLExtension)

+ (instancetype)fl_jsonToModel:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
