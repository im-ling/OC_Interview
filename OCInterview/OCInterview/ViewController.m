//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import "ViewController.h"
#import "WBLCornerShadowView.h"
@interface ViewController ()
@end

@implementation ViewController{
    UIView *viewPointer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    WBLCornerShadowView *view = [[WBLCornerShadowView alloc] init];
    view.frame = CGRectMake(100, 100, 100, 100);
    view.backgroundColor = UIColor.systemBlueColor;
    view.corners = 0;
    view.cornerRadius = 30;

    view.shadowRadius = 10;
    view.shadowOpacity = 0.2;
    view.shadowColor = UIColor.blackColor;
    view.shadowDirections = WBLShadowDirectionAll;
    [self.view addSubview:view];
    
    viewPointer = view;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self->viewPointer.frame = CGRectMake(100, 100, 200, 200);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->viewPointer.frame = CGRectMake(100, 100, 200, 200);
    });
}


@end
