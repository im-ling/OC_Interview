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
    void *p = NULL;
    {
        NSObject *obj = [[NSObject alloc] init];
        NSLog(@"%p", obj);
        p = (__bridge_retained void *)obj;
    }
    NSLog(@"%p %@", p, p);
//    CFRelease(p);
    {
        id obj = (__bridge_transfer NSObject *)p;
    }
//    NSLog(@"%p %@", p, p);
}


@end
