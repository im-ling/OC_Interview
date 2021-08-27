//
//  TestError.h
//  test
//
//  Created by liling on 2021/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestError : NSError
+ (NSError *)errorWithDescription:(NSString *)description;
@end

NS_ASSUME_NONNULL_END
