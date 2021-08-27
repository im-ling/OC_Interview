//
//  TestDispatch.h
//  test
//
//  Created by liling on 2021/8/25.
//

#import <Foundation/Foundation.h>
#import "TestProxy.h"

NS_ASSUME_NONNULL_BEGIN



@interface TestDispatch : NSObject
- (NSError *)add:(Protocol *)interface listener:(id)listener;
- (NSError *)remove:(Protocol *)interface listener:(id)listener;
- (TestProxy *)getDispatcher:(Protocol *)interface;
@end

NS_ASSUME_NONNULL_END
