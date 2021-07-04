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

+ (instancetype)sharedVC{
    static ViewController* _vc;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _vc = [[ViewController alloc] init];
    });
    return _vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
