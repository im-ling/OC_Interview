//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import <objc/runtime.h>
#import "ViewController.h"

@interface ObjectA: NSObject

@property (nonatomic) NSInteger age;
@property (nonatomic) NSString *name;

@end

@implementation ObjectA
- (void)say{
    NSLog(@"A");
}
@end

@interface ObjectA1: ObjectA
@end

@implementation ObjectA1


+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 交换对象方法
        [self swizzleMethod:self orgSel:@selector(sub_say) swizzSel:@selector(say)];
//      [self swizzleMethod:objc_getClass("__NSArrayI") orgSel:@selector(objectAtIndex:) swizzSel:@selector(safe_objectAtIndex:)];
//        // 交换类方法
//      [self swizzleMethod:object_getClass((id)self) orgSel:@selector(arrayWithObjects:count:) swizzSel:@selector(safe_arrayWithObjects:count:)];
    });
}

+ (BOOL)swizzleMethod:(Class)class orgSel:(SEL)origSel swizzSel:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method altMethod = class_getInstanceMethod(class, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
//    BOOL didAddMethod = class_addMethod(class,origSel,
//                                        method_getImplementation(altMethod),
//                                        method_getTypeEncoding(altMethod));
//
//    if (didAddMethod) {
//        class_replaceMethod(class,altSel,
//                            method_getImplementation(origMethod),
//                            method_getTypeEncoding(origMethod));
//    } else {
        method_exchangeImplementations(origMethod, altMethod);
//    }
    
    return YES;
}

- (void)sub_say{
    NSLog(@"A1");
//    [self sub_say];
}

@end

@interface ObjectA2: ObjectA
@end

@implementation ObjectA2
@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[ObjectA alloc] init] say];
    [[[ObjectA1 alloc] init] say];
    [[[ObjectA1 alloc] init] sub_say];
    [[[ObjectA2 alloc] init] say];
}


@end
