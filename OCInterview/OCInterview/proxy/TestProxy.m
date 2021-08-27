//
//  TestProxy.m
//  OCInterview
//
//  Created by liling on 2021/8/25.
//

#import "TestProxy.h"
#import <objc/runtime.h>

struct objc_method_description _wbl_method_description(Protocol *protocol, SEL sel) {
    struct objc_method_description description = protocol_getMethodDescription(protocol, sel, YES, YES);
    if (description.types) {
        return description;
    }
    description = protocol_getMethodDescription(protocol, sel, NO, YES);
    if (description.types) {
        return description;
    }
    return (struct objc_method_description){NULL, NULL};
}

BOOL _wbl_protocol_sel_avaible(Protocol *protocol, SEL sel) {
    return _wbl_method_description(protocol, sel).types ? YES: NO;
}


@interface TestProxy()
@end

@implementation TestProxy

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (!_wbl_protocol_sel_avaible(self.prococol, aSelector)) {
        return [super methodSignatureForSelector:aSelector];
    }
    
    struct objc_method_description methodDescription = _wbl_method_description(self.prococol, aSelector);
    return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = anInvocation.selector;
    if (!_wbl_protocol_sel_avaible(self.prococol, aSelector)) {
        [super forwardInvocation:anInvocation];
        return;
    }

    for (id implemertorContext in self.listeners) {
        if ([implemertorContext respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:implemertorContext];
        }
    }
}

@end
