//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import "ViewController.h"
#include "WBLPriorityQueue.h"

@interface TestObj:NSObject
@property(nonatomic, assign)int weight;
- (instancetype)initWithWeight:(int)weight;
@end

@implementation TestObj
- (instancetype)initWithWeight:(int)weight{
    if (self = [super init]) {
        self.weight = weight;
    }
    return self;
}

- (void)dealloc{
    NSLog(@"%s %d", __func__, self.weight);
}

@end


@interface ViewController (){
    WBLPriorityQueue *queue;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    queue = [[WBLPriorityQueue alloc] init];
    for (int i = 0; i < 100; i++) {
        [queue pushObject:[[TestObj alloc] initWithWeight:i] withWeight:i];
    }
    while (queue.count > 10) {
        @autoreleasepool {
            NSLog(@"%d", [[queue pop] weight]);
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"1111");
        self->queue = nil;
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"2222");
    });

    
    // Do any additional setup after loading the view.
}


@end
