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

@interface WBLPriorityNode : NSObject
@property (nonatomic,strong) id obj;
@property (nonatomic,assign) unsigned int weight;
+ (instancetype)initWithObj:(id)obj weight:(unsigned)weight;
@end

@implementation WBLPriorityNode
+ (instancetype)initWithObj:(id)obj weight:(unsigned)weight{
    WBLPriorityNode *node = [[WBLPriorityNode alloc] init];
    node.obj = obj;
    node.weight = weight;
    return node;
}
- (void)dealloc{
    NSLog(@"%s, %d", __func__, self.weight);
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
}

#pragma mark -

- (instancetype)init{
    if (self = [super init]) {
        std::priority_queue<WBLPriorityNode *, std::vector<WBLPriorityNode *>, WBLPriorityNodeCompare> pq;
        _priority_queue = pq;
    }
    return self;
}

- (unsigned int)count
{
    return (unsigned int) _priority_queue.size();
}

- (void)pushObject: (id)obj withWeight: (unsigned)weight{
    WBLPriorityNode *node = [WBLPriorityNode initWithObj:obj weight:weight];
    _priority_queue.push(node);
}

- (id)pop
{
    id temp = _priority_queue.top().obj;
    _priority_queue.pop();
    return temp;
}
@end
