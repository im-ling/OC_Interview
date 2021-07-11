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
@end

@interface ObjectB: NSObject
@end

@implementation ObjectB

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", keyPath);
    NSLog(@"%@", object);
    NSLog(@"%@", change);
}
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //生成对象
    ObjectA *objA = [[ObjectA alloc] init];
    ObjectB *objB = [[ObjectB alloc] init];
    
    // 添加Observer之后
    [objA addObserver:objB forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    objA.age = 5;


    // 输出ObjectA
    NSLog(@"%@ %p", [objA class], [objA class]);
    // 输出NSKVONotifying_ObjectA（object_getClass方法返回isa指向）
    Class cls = object_getClass(objA);
    NSLog(@"%@ %p", cls, cls);

    
    [objA addObserver:objB forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    NSLog(@"%@ %p", [objA class], [objA class]);
    NSLog(@"%@ %p", cls, cls);

}


@end
