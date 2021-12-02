//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import "ViewController.h"
#import <Lottie/Lottie.h>
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    LOTAnimationView *lotiView = [LOTAnimationView animationNamed:@"wbl_lottie_countdown"];
    lotiView.contentMode = UIViewContentModeScaleAspectFill;
    lotiView.completionBlock = ^(BOOL animationFinished) {
        NSLog(@"123");
    };
    lotiView.frame = self.view.frame;
    [self.view addSubview:lotiView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [lotiView play];
    });
}


@end
