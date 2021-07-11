//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import "ViewController.h"

@interface TestView: UIView

@end
@implementation TestView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch testview");
}
@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestView *view = [[TestView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor systemBlueColor];
    [self.view addSubview:view];
    
    UIView *redView = [[UIView alloc] initWithFrame:self.view.frame];
    redView.backgroundColor = [UIColor systemRedColor];
    redView.userInteractionEnabled = FALSE;
    [self.view addSubview:redView];
    
    // Do any additional setup after loading the view.
}



@end
