//
//  ViewController.m
//  OCInterview
//
//  Created by NowOrNever on 05/07/2021.
//

#import <objc/runtime.h>
#import <malloc/malloc.h>
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

- (void)run {
    NSLog(@"2");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIImageView 设置了图片+背景色;
    UIImageView *img1 = [[UIImageView alloc]init];
    img1.frame = CGRectMake(100, 320, 100, 100);
    img1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:img1];
    img1.layer.cornerRadius = 50;
    img1.layer.masksToBounds = YES;
    img1.image = [UIImage imageNamed:@"btn.jpeg"];
    //UIImageView 只设置了图片,无背景色;
    UIImageView *img2 = [[UIImageView alloc]init];
    img2.frame = CGRectMake(100, 480, 100, 100);
    [self.view addSubview:img2];
    img2.layer.cornerRadius = 50;
    img2.layer.masksToBounds = YES;
    img2.image = [UIImage imageNamed:@"btn.jpeg"];
    
//    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        NSLog(@"1");
//        [self performSelector:@selector(run) withObject:nil afterDelay:1];
////        [[NSRunLoop currentRunLoop] run];
//
////        [self performSelector:@selector(run)];
//        NSLog(@"3");
//    });
    
    
//    NSObject* obj = [[NSObject alloc]init];
//
//    // 获取实例对象至少需要分配的内存大小，实际真正占用的大小，8 字节
//    size_t insSize = class_getInstanceSize([NSObject class]);
//    NSLog(@"NSObject Size:%zd",insSize);
//    // 同上
//    insSize = class_getInstanceSize([obj class]);
//    NSLog(@"NSObject Size:%zd",insSize);
//
//    // 获取实际分配内存大小，最终分配的大小，16 字节
//    size_t mSize = malloc_size((__bridge const void *)obj);
//    NSLog(@"malloc Size:%zd",mSize);
    
//    TestView *view = [[TestView alloc] initWithFrame:self.view.frame];
//    view.backgroundColor = [UIColor systemBlueColor];
//    [self.view addSubview:view];
//
//    UIView *redView = [[UIView alloc] initWithFrame:self.view.frame];
//    redView.backgroundColor = [UIColor systemRedColor];
//    redView.userInteractionEnabled = FALSE;
//    [self.view addSubview:redView];
    
    // Do any additional setup after loading the view.
}



@end
