//
//  TestProxy.h
//  OCInterview
//
//  Created by liling on 2021/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestProxy : NSProxy
@property (nonatomic, weak) Protocol *prococol;//本次代理的事件协议
@property (nonatomic, weak) NSArray *listeners;//
@end

NS_ASSUME_NONNULL_END
