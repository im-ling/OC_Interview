//
//  TestError.m
//  test
//
//  Created by liling on 2021/8/25.
//

#import "TestError.h"

NSErrorDomain WBLEventErrorDomain = @"TestEventError";

@implementation TestError
+ (NSError *)errorWithDescription:(NSString *)description;
{
    return [NSError errorWithDomain:description code:-1 userInfo:nil];
}
@end
