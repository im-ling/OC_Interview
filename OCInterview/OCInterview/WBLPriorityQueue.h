//
//  WBLPriorityQueue.h
//
//  Created by liling on 2021/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBLPriorityQueue : NSObject

- (instancetype)init;
- (unsigned)count;
//- (void)addObject: (id)obj value: (unsigned)val;
- (void)pushObject: (id)obj withWeight: (unsigned)val;
- (id)pop;

@end

NS_ASSUME_NONNULL_END
