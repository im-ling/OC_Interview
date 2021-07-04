//
//  NSSafeMutableArray.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import "NSSafeMutableArray.h"

@interface NSSafeMutableArray ()
@property (nonatomic, strong) NSMutableArray *mArr;
@property (nonatomic, strong) NSLock *lock;
@end

@implementation NSSafeMutableArray

- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"create NSSafeMutableArray %p", self);
        self.mArr = [NSMutableArray array];
        self.lock = [[NSLock alloc] init];
        return self;
    }
    return nil;
}

- (void)addObject:(NSObject *)anObject{
    [self.lock lock];
    [self.mArr addObject:anObject];
    [self.lock unlock];
}

- (void)insertObject:(NSObject *)anObject atIndex:(NSUInteger)index{
    [self.lock lock];
    [self.mArr insertObject:anObject atIndex:index];
    [self.lock unlock];
}

- (void)removeLastObject{
    [self.lock lock];
    [self.mArr removeLastObject];
    [self.lock unlock];
}

- (void)removeObjectAtIndex:(NSUInteger)index{
    [self.lock lock];
    [self.mArr removeObjectAtIndex:index];
    [self.lock unlock];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(NSObject *)anObject{
    [self.lock lock];
    [self.mArr replaceObjectAtIndex:index withObject:anObject];
    [self.lock unlock];
}

- (id)objectAtIndex:(NSUInteger)index{
    [self.lock lock];
    id obj = self.mArr[index];
    [self.lock unlock];
    return obj;
}



@end
