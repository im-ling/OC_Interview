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

- (void)pushObject: (id)obj withWeight: (int)val;

- (id)pop;

- (id)top;

- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
