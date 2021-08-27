//
//  NSPointerArray+Helper.m
//  OCInterview
//
//  Created by liling on 2021/8/25.
//

#import "NSPointerArray+Helper.h"

@implementation NSPointerArray (Helper)
- (void)addObject:(id)object
{
    [self addPointer:(__bridge void *)object];
}

- (BOOL)containsObject:(id)object
{
    // get passed in object's pointer
    void * objPtr = (__bridge void *)object;
    for (NSUInteger i = 0; i < [self count]; i++) {
        void * ptr = [self pointerAtIndex:i];
        
        if (ptr == objPtr) {
            return YES;
        }
    }
    
    return NO;
}

- (void)removeObject:(id)object
{
    // get pointer to the passed in object
    void * objPtr = (__bridge void *)object;
    int objIndex = -1;
    for (NSUInteger i = 0; i < [self count]; i++) {
        void * ptr = [self pointerAtIndex:i];
        
        if (ptr == objPtr) {
            // pointers equal, found our object!
            objIndex = i;
            break;
        }
    }
    
    // make sure index is non-nil and not outside bounds
    if (objIndex >= 0 && objIndex < [self count]) {
        [self removePointerAtIndex:objIndex];
    }
}
@end
