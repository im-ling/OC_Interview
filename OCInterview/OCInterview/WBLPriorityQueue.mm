//
//  WBLPriorityQueue.m
//
//  Created by liling on 2021/11/9.
//

#include <stdio.h>
#include <queue>
#include <iostream>
#include <vector>
#import "WBLPriorityQueue.h"
#import <pthread/pthread.h>

@interface WBLPriorityNode : NSObject

@property (nonatomic,strong) id obj;
@property (nonatomic,assign) int weight;

+ (instancetype)initWithObj:(id)obj weight:(int)weight;

@end

@implementation WBLPriorityNode

+ (instancetype)initWithObj:(id)obj weight:(int)weight{
    WBLPriorityNode *node = [[WBLPriorityNode alloc] init];
    node.obj = obj;
    node.weight = weight;
    return node;
}

@end


class WBLPriorityNodeCompare {
public:
    bool operator()(WBLPriorityNode *n1,WBLPriorityNode *n2) const {
        return n1.weight > n2.weight;
    }
};


@implementation WBLPriorityQueue{
    std::priority_queue<WBLPriorityNode *, std::vector<WBLPriorityNode *>, WBLPriorityNodeCompare>_priority_queue;
    pthread_rwlock_t rwlock;
}

#pragma mark -
- (instancetype)init{
    if (self = [super init]) {
        std::priority_queue<WBLPriorityNode *, std::vector<WBLPriorityNode *>, WBLPriorityNodeCompare> pq;
        _priority_queue = pq;
        pthread_rwlock_init(&rwlock,NULL);
    }
    return self;
}

- (unsigned int)count{
    pthread_rwlock_rdlock(&rwlock);
    unsigned int result = (unsigned int) _priority_queue.size();
    pthread_rwlock_unlock(&rwlock);
    return result;
}

- (void)pushObject: (id)obj withWeight:(int)weight{
    pthread_rwlock_wrlock(&rwlock);
    WBLPriorityNode *node = [WBLPriorityNode initWithObj:obj weight:weight];
    _priority_queue.push(node);
    pthread_rwlock_unlock(&rwlock);
}

- (id)pop{
    if ([self isEmpty]) return nil;
    pthread_rwlock_wrlock(&rwlock);
    id result = _priority_queue.top().obj;
    _priority_queue.pop();
    pthread_rwlock_unlock(&rwlock);
    return result;
}

- (id)top{
    if ([self isEmpty]) return nil;
    pthread_rwlock_rdlock(&rwlock);
    id result = _priority_queue.top().obj;
    pthread_rwlock_unlock(&rwlock);
    return result;
}

- (BOOL)isEmpty{
    pthread_rwlock_rdlock(&rwlock);
    BOOL result = _priority_queue.size() == 0;
    pthread_rwlock_unlock(&rwlock);
    return result;
}

- (void)dealloc{
    pthread_rwlock_destroy(&rwlock);
}
@end
