//
//  NSSafeMutableArray.h
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSafeMutableArray : NSObject
- (void)addObject:(NSObject *)anObject;
- (void)insertObject:(NSObject *)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(NSObject *)anObject;
- (id)objectAtIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
