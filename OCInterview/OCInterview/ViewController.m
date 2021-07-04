//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testBlock];
}

- (void)testBlock {
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1,@2, nil];
//    __block NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1,@2, nil];
    void(^block)(void) = ^{
        NSLog(@"block start");
        for (NSObject *obj in arr) {
            NSLog(@"%@", obj);
        };
    };
    [arr addObject:@3];
    arr = nil;
    block();
}


@end
