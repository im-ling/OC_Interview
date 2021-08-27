//
//  TestDispatch.m
//  test
//
//  Created by liling on 2021/8/25.
//

#import "TestDispatch.h"
#import "TestProxy.h"
#import "TestError.h"
#import "NSPointerArray+Helper.h"

void WBLPerformBlockOnMainThread(void (^ _Nonnull block)(void))
{
    if (!block) return;
    
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

@interface TestDispatch()

@property (nonatomic,strong)NSMutableDictionary *events;

@end

@implementation TestDispatch

#pragma mark - EventCenter Public Methods
- (TestProxy *)getDispatcher:(Protocol *)interface;
{
    @synchronized (self) {
        TestProxy *proxy = [TestProxy alloc];
        proxy.listeners = [self _getListeners:interface];
        proxy.prococol = interface;
        return proxy;
    }

}

- (NSError *)add:(Protocol *)interface listener:(id)listener;
{
    NSError *error = nil;
    @synchronized (self) {
        error = [self _add:interface listener:listener];
    }
    return error;
}

- (NSError *)remove:(Protocol *)interface listener:(id)listener;
{
    NSError *error = nil;
    @synchronized (self) {
        error = [self _remove:interface listener:listener];
    }
    return error;
}

#pragma mark - EventCenter Private Methods

- (NSMutableDictionary *)events
{
    if (!_events) {
        _events = [[NSMutableDictionary alloc] init];
    }
    return _events;
}

- (NSError *)_add:(Protocol *)interface listener:(id)listener;
{
    NSPointerArray *events = [self _eventsFromProtocol:interface];
    if ([events containsObject:listener]) {
        return [TestError errorWithDescription:@"重复添加事件中心用户"];
    }
    [events addObject:listener];
    return nil;
}

- (NSError *)_remove:(Protocol *)interface listener:(id)listener;
{
    NSPointerArray *events = [self _eventsFromProtocol:interface];
    if (![events containsObject:listener]) {
        return [TestError errorWithDescription:[NSString stringWithFormat:@"准备移除的事件中心用户未注册至 %@ 或已释放",NSStringFromProtocol(interface)]];
    }
    [events removeObject:listener];
    return nil;
}

- (NSArray *)_getListeners:(Protocol *)interface;
{
    NSPointerArray *events = [self _eventsFromProtocol:interface];
    return events.allObjects;
}

- (NSPointerArray *)_eventsFromProtocol:(Protocol *)eventProtocol
{
    NSString *eventName = NSStringFromProtocol(eventProtocol);
    if (![self.events objectForKey:eventName]) {
        NSPointerArray *pointerArray = [NSPointerArray weakObjectsPointerArray];
        [self.events setObject:pointerArray forKey:eventName];
    }
    NSPointerArray *table = [self.events objectForKey:eventName];
    
    return table;
}
@end
