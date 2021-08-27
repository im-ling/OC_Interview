//
//  TestProxyViewController.m
//  OCInterview
//
//  Created by liling on 2021/8/25.
//

#import "TestProxyViewController.h"

@interface TestProxyViewController ()

@end

@implementation TestProxyViewController

- (void)say{
    NSLog(@"%s %@", __func__, _name);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
